From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Make tig call the correct git config command
Date: Sun, 8 Feb 2009 10:56:59 +0100
Message-ID: <2c6b72b30902080156u3b8ba41m736bffaa7b6f15e9@mail.gmail.com>
References: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com>
	 <237967ef0902072349t784e1519m3561ef02545a72de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6Qp-0008NH-Bh
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbZBHJ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZBHJ5D
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:57:03 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41342 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZBHJ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:57:01 -0500
Received: by bwz5 with SMTP id 5so458414bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=MNQ+UfbrOkzl7jBuCBSanSNP1eeGeiqM4nbN+VJuDLA=;
        b=FpIC7cN04bCKay8cerZGGyruqdKERM42DcmWllr3SuQO2Ymk4PW913AwFdyGjB5Uat
         PW+htKQDWyqlU7/2Ci2kaOECEekOvQjr9pRzNyXYefWy77/kxwrzb4YJaPNkb8wXAklI
         fTl9DsZ+J9X9ZfgFgjax70oWBgtwpSW6b1P5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Den3fLDj3uRmgkIVo0DUU7hyb8lUCCXqNX9o87xIkrCoxS/gWnpOEtJgEDmxpUDZBv
         LAVwyCmBnXbv+u7pMGFw4DM0tGQcFbty8+/fYU6PTaXArcVAR8lrHWnGnLWgI99BMjaU
         CqOAukcUYr2zKOlf7czioXSXF/9TW1SAWbFXU=
Received: by 10.180.247.12 with SMTP id u12mr340654bkh.154.1234087019936; Sun, 
	08 Feb 2009 01:56:59 -0800 (PST)
In-Reply-To: <237967ef0902072349t784e1519m3561ef02545a72de@mail.gmail.com>
X-Google-Sender-Auth: c681b5b0a580f7e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108941>

On Sun, Feb 8, 2009 at 08:49, Mikael Magnusson <mikachu@gmail.com> wrote:
> As it turns out I'm an idiot, that's just the configure help message.
> Rerunning autoconf + configure in fact generates a completely correct
> commandline. Sorry about the noise.

Thanks for checking anyway. The Makefile doesn't detect out-of-date
configure scripts, which (after the move to use argv arrays and execv
in tig-0.13) caused tig to run: "'git' 'git config'" on startup.

I wonder if this check in configure should not be removed anyway,
since it is starting to be a long time since git-repo-config was
renamed.

-- 
Jonas Fonseca
