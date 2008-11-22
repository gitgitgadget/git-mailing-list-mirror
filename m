From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into a git work-dir
Date: Sat, 22 Nov 2008 13:54:09 -0800 (PST)
Message-ID: <m31vx3l94x.fsf@localhost.localdomain>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
	<1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L40Rt-0006Fo-OU
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 22:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYKVVyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbYKVVyN
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 16:54:13 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:23498 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbYKVVyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 16:54:12 -0500
Received: by ey-out-2122.google.com with SMTP id 6so614876eyi.37
        for <git@vger.kernel.org>; Sat, 22 Nov 2008 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Io0vPBFDiHejQFKztHt+PZzg96Q8zw5nVpr7zOgxWws=;
        b=ZSMJVQGM198VdL+b7cuFh26t6W3D6ll32n7fqKL1IDtf8KhuNiwuw0Mltl3syIBjs3
         9bP1sZv5cbX/Is8SOKr8n4TTlwmXCkYQ/ENXoFqzJR3Uj2S09rTlLf/F/mYUn7egxMr0
         981zl+c4+xmrQo9XJk/OzQI7TkdhpNTuyOulQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=P3gEuBEin39lcjAfjZ3IFgEe2EPAABUvAFZgsxtsNa6fb3S9X+Xjkc6fwTtzzh3jEH
         TLUnp5uirmsmSEiz8r4PbpRhSYGYPunv2bTfPXCHx+lRf6cEDwPXq9/r3SvzCHLOd4HK
         IaQ6OtVAta8SWdW0/K3oVPwte7blj4HEvUr9w=
Received: by 10.210.19.11 with SMTP id 11mr2061936ebs.168.1227390850724;
        Sat, 22 Nov 2008 13:54:10 -0800 (PST)
Received: from localhost.localdomain (abwv41.neoplus.adsl.tpnet.pl [83.8.245.41])
        by mx.google.com with ESMTPS id b30sm3598728ika.7.2008.11.22.13.54.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Nov 2008 13:54:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAMLs9eE022303;
	Sat, 22 Nov 2008 22:54:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAMLs7Mq022300;
	Sat, 22 Nov 2008 22:54:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101558>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> * Change "git rev-parse --show-cdup" to print a full path instead of
>   a series of "../" when it prints anything

But that is contrary to the _name_ of option. It is --show-cdup, as
in "show cd up". And I think your change will break a few scripts.

I think you should use "git rev-parse --work-tree" for full path
to working directory:

    --show-cdup
        When the command is invoked from a subdirectory, show the path
        of the top-level directory relative to the current directory
        (typically a sequence of "../", or an empty string).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
