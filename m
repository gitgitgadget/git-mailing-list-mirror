From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 14:58:20 +0200
Message-ID: <20130627125820.GA27497@paksenarrion.iveqy.com>
References: <20130627124656.GA2620@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 14:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsBmd-00041u-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 14:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab3F0M6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 08:58:42 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:65000 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3F0M6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 08:58:40 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so788369lab.28
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Pue/ub7RsJMfLamQsTivh3q1WKfxZfoDL8cJstceeE=;
        b=yoz8Drjb6Shz6ujwUnSP151cnv0NKO3pOniUFW0lp9pINBppdi5wscb+wJr9v+2Xb3
         2c4HDZ67GFzLbKEYJytXYUiSUBgFcjAgO9Ni3ApdbiQtbyTr2OPRPi4NuNXjrI58scLc
         eYK5nLudy6WH3M8yddNYXA5JYxjunezqOSSMGGtBBJCoFM2BLwwUXkHRf75wRHlFYnYI
         Kv9nGcJWrOt5BzEO1ggED71PM3YVW8sS/RfnhiM1XD3D4WPJX24eUg8UQ5Rq7Ld/hByI
         9OyxaBcl5Z5gOvqWK4pWjPjkY+fdrl7QPstWqmP7GJeyLqBZil/b2kd+P58FcPWs1krH
         BnoQ==
X-Received: by 10.152.4.163 with SMTP id l3mr4142450lal.60.1372337918904;
        Thu, 27 Jun 2013 05:58:38 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id rx1sm1144683lbb.0.2013.06.27.05.58.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 05:58:38 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsBmG-0001SL-CA; Thu, 27 Jun 2013 14:58:20 +0200
Content-Disposition: inline
In-Reply-To: <20130627124656.GA2620@zuhnb712>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229098>

On Thu, Jun 27, 2013 at 08:46:56PM +0800, Woody Wu wrote:
> Hi,
>=20
> I have a colleague who has to left our office for three month, but st=
ill
> need to work on the project which is hosted on our in-office git
> repository. Problem is that our company has firewall, it's not possib=
le
> or not allowed to access the company LAN outside the building.  So I
> want to ask you expert, can you suggest a best practice of git workfl=
ow
> that suitable to my situation?

There's a number of ways that git can communicate with an other git
repo. However, communication needs access. You can for example e-mail
changes or sen them as files manually with git sneakernet functionality=
=2E
However those cases would be as bad (or worse) than to open your
firewall.

The "best" solution would be a remote repository outside your firewall
where your inhouse team and your outhouse developer can share stuff wit=
h
eachother. However the securitry for this special project will be lower=
=2E
(Maybe this isn't an important project to you, I don't know). This
repository can be at your inhouse-site, at your developer or at some
third part. Use ssh with keys and passphrases to communicate.

Keep in mind that a git repository contains all of your source history.
Your security for that source code will be whatever security your
outhouse developer has. If he fails with his security, there's no
meaning with having great inhouse security.

If this isn't an option I would suggest that you establish an encrypted
sneakernet (for example over UPS/bike messengers/whatever) between your
developer and your office. Or just ask yourself if your security
settings really is sane.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
