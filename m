From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/2] Support addresses with ':' in git-daemon
Date: Wed, 27 Jan 2010 06:53:28 +0800
Message-ID: <be6fef0d1001261453v2fd624fdv88640aa706c0009@mail.gmail.com>
References: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <1264530282-4783-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZuHw-0005ZK-FE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 23:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab0AZWxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 17:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938Ab0AZWxa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 17:53:30 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:40145 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0AZWx3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 17:53:29 -0500
Received: by iwn3 with SMTP id 3so912695iwn.19
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UFMQ63LFa03azOZFGp1ZL02KW0YYHMGofMBdbwszK/0=;
        b=bNtvgF8SZkHVtCEOOYWoTt/EF7h4cZuhS6H20bYM17zN7XA3NjVldG1XGra30yj5Mz
         Sx6usTdG85aSwo0Q/w7KWF21mhsJa40jcBJKxZbjxVgY3G1f5iak3OS6m/v+9bgEDl0m
         cyTXQ6SbRirc3eJ60jBRy3sC3x1Q9umsVDyuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IOC22ip7w/1lqV3587Lz+6Ynww3b5Ii99FY9AxCx6lRZn9BCIIfB2B6iQE+P8tIcv2
         V97CvsxVhBbQ8msmpXBkhSflU9LD82psQTwwL8LljgXckqQ5giLyg0Qqj5O3cWsieBjC
         K5vBXmsw5WqvXcGBgkTBxDe9kHqyTqVPZAlqw=
Received: by 10.231.168.132 with SMTP id u4mr320850iby.79.1264546408349; Tue, 
	26 Jan 2010 14:53:28 -0800 (PST)
In-Reply-To: <1264530282-4783-2-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138082>

Hi,

On Wed, Jan 27, 2010 at 2:24 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> diff --git a/daemon.c b/daemon.c
> index 360635e..6c2bd97 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -399,6 +399,33 @@ static char *xstrdup_tolower(const char *str)
> =A0 =A0 =A0 =A0return dup;
> =A0}
>
> +static void parse_host_and_port(char *hostport, char **host,
> + =A0 =A0 =A0 char **port)
> +{
> + =A0 =A0 =A0 if (*hostport =3D=3D '[') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *end;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D strchr(hostport, ']');
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Invalid reqeuest (=
'[' without ']')");

s/reqeuest/request/.

--=20
Cheers,
Ray Chuan
