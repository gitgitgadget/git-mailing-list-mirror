From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 13:37:48 -0500
Message-ID: <20100330183748.GA10647@progeny.tock>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 20:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwgJp-0008Km-4B
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 20:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0C3Shg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 14:37:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61292 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0C3Shf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 14:37:35 -0400
Received: by pva18 with SMTP id 18so2960516pva.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SKNv0pobK6Vz+wk9NtMqN3B2n3rZpyKWPUGbEPfSJDA=;
        b=TmRqIXE9aH/AY2yybWlCyzIjvD/x5pcUxnwf92qFr3dFX06jldz3v0Df0SjNJQY2Th
         /YbfP6AM3lMbnnupHF+Fylkfiz2GoNnogrEM+8quy5zDx9FgZL9oN8yjSwmFDp42AXuP
         BQFP+KLwiPi6lrijyjLlKPS5ECyoTUqQ/vVjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dPE0tDhnFpMCejXoneoIlQEhdm0fXMp7dcHA7zTbPe7n7VazRq8xs8SWvxBHNMlTgj
         GckB7qAXWtp7zIHdg7jzCmAnFtmN9xSC2xs28gq/u4fq9dRsmLsTjKdU7bZe3Y2MNF9V
         XBZb7JqLV4obOMLDq2xIANSUaLgJ0u/vx+pDU=
Received: by 10.141.89.14 with SMTP id r14mr1530580rvl.33.1269974254856;
        Tue, 30 Mar 2010 11:37:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5291149iwn.3.2010.03.30.11.37.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 11:37:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143589>

Hi Ram,

Ramkumar Ramachandra wrote:

> +INVOCATION
> +----------
> +
> +Remote helper programs are invoked with one or optionally two
> +arguments on the command line. The first argument specifies a remote
> +to use; typically, it is either the name of a remote in the
> +configuration or just a URL. The second argument is a URL, and serve=
s
> +to resolve ambiguities that may arise when only the first argument i=
s
> +specified.

This last sentence (=E2=80=9Cambiguities that may arise=E2=80=9D) raise=
s more questions
than it answers in my opinion.  Maybe it would make sense to say

 The first argument identifies a <repository> as it would be specified =
to
 git; typically, this is either a configured remote nickname or a URL.

 The second argument, if present, is a URL for the remote repository.
 without such an argument, invocations for remotes with multiple
 URLs set would be ambiguous.  If the second argument is missing,
 this remote nickname does not have a URL set and should probably have
 some transport-specific configuration set up separately.

 The URL in the second argument can be an arbitrary string.  It is up
 to the remote helper to assign meaning to it.

or something to that effect.

Jonathan
