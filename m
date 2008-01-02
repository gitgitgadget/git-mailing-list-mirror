From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 01:34:04 -0500
Message-ID: <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>
References: <477B39B5.5010107@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Gonzalo_Garramu=F1o?=" <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 07:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9xBT-0003ls-Vy
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 07:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbYABGeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 01:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYABGeG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 01:34:06 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:23289 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbYABGeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 01:34:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5153368rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 22:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=LjiAP9uyQm1BW4tOtVwCwU+7q82GsDJj3Av6xxFeK0s=;
        b=bJmyj3G3o5pIw3BCAdNU4NmW7LlKvDaQCFc0YCM8mUq+k1UsUYhDg01q8veeuZ8XraOmJL7+9lsAm/FKikwe654J+bvIZ1AcxDqVRkrrVdB1CXLeWwbhdyUJqJQMwfS3gG5VnNFBhlHgl0cjGuTh9FaCPwrQhASoVZOPXoxG4bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mE/svUwuDWPcTByd8F1PHooKuKJKe8fsk091BFjYSxeG2R5L50I7pySYnPYuLlS22YsG8+7E48nLvD6DsaKxl8bgdDCfZsG6Z7z9du2t4C2y5ZIl5T+aZoyCeFnfGD/5G7YNqPnPFrceTHbUHqbHyrBfHvAslCmyIgvcGpFw32A=
Received: by 10.142.232.20 with SMTP id e20mr1161690wfh.198.1199255644554;
        Tue, 01 Jan 2008 22:34:04 -0800 (PST)
Received: by 10.143.158.13 with HTTP; Tue, 1 Jan 2008 22:34:04 -0800 (PST)
In-Reply-To: <477B39B5.5010107@advancedsl.com.ar>
Content-Disposition: inline
X-Google-Sender-Auth: 8fbb85ab325c9ffa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69459>

On Jan 2, 2008 2:13 AM, Gonzalo Garramu=F1o <ggarra@advancedsl.com.ar> =
wrote:
>
> I've been using git for some time and love it.  For open source proje=
cts
> there's clearly nothing currently better.
>
> However, I am now using git for proprietary elements, which in the
> future I may need or want to partially restrict access to.  The idea
> being that at my company some (junior) developers should not be given
> access to some elements.  That means either that some full git
> repository should be password protected or even portions of the same
> repository.
>
> Another desirable way to protect elements might be only giving
> clone/pull access to a repository (or portion of it) but not permissi=
ons
> to push in changes.

push access is only available through ssh, so if your developer
doesn't have a ssh account on the server, he can't push code to it

>
> I have not seen or read much about how git deals with accesses and
> permissions.  Can anyone point me to some documentation if some or al=
l
> of this is possible?

it's easy on the full repository case, create different groups and
share git repositories by groups, after that chmod o-rwx -R
/path/to/repository.git.

If a user is not the owner nor is part of that group in particular, it
wouldn't be able to push any code to the repository.

btw, if you don't start git-daemon you could use ssh to pull code as we=
ll.

thinking on the partial repository access, maybe git submodule would
help, but i've never used it.

--=20
Best Regards,

=46elipe Balbi
felipebalbi@users.sourceforge.net
