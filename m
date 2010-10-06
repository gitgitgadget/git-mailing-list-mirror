From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv5 06/17] gitweb/lib - Simple select(FH) based output capture
Date: Wed, 6 Oct 2010 23:52:29 +0100
Message-ID: <AANLkTinO+wo8z_peiDragtZ1Y8rJZ1UziMXh2YqSJaLD@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-7-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cr2-0001Wc-4Y
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285Ab0JFWwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:52:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40206 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab0JFWwp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:52:45 -0400
Received: by bwz11 with SMTP id 11so74940bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=yL09+D29qxU3UTL9ygimg24oDuT+BQZk/YZDk5T1As4=;
        b=BrjJi5R3OThvUsnV4PmJ5tfaugZRcQq0jQKRiZh+JJD/Alo28khjKRqK0sdJHPblhb
         +OoxemV6Zu8HHb0h17PKeu9leUj8v4SSSTpZrNw0S97WxF+YtOSX/aSG+tu2UQFVd1BD
         WI8XW5qa4fAPyg/fqA4L36ZFSuCc9EbTeidA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=P+XVeBMTppAaMbZ7clLk0pOYqMU2xLuUyboz4ISWjFJj9Xnl5M+FjW14UAl0BWtVY8
         SsYCNEBP9inHZSnduSmwuqCfX7DBZLPH5VIYBwQGw2Csi8WGsI3NvdOcZY6AGGRxfmjZ
         xr58l2plTJjvAUMDK42KtXe8/s8FkyRYfK4cg=
Received: by 10.204.55.211 with SMTP id v19mr10183452bkg.153.1286405564244;
 Wed, 06 Oct 2010 15:52:44 -0700 (PDT)
Received: by 10.204.75.155 with HTTP; Wed, 6 Oct 2010 15:52:29 -0700 (PDT)
In-Reply-To: <1286402526-13143-7-git-send-email-jnareb@gmail.com>
X-Google-Sender-Auth: p4VgMMgN27D8WRIquns2Jkxp1oY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158341>

Hi --

On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:
> +sub capture {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $code) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 $self->start();
> + =C2=A0 =C2=A0 =C2=A0 $code->();

unless( defined $code and $code eq 'CODE' )
{
       # Error?
        ....
}

> + =C2=A0 =C2=A0 =C2=A0 return $self->stop();
> +}
> +
> +# Wrap caching data; capture only STDOUT
> +sub capture_block (&) {

This is prototyped deliberately?

-- Thomas Adam
