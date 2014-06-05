From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 11:40:50 +0200
Message-ID: <53903B22.70507@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Erik Faye-Lund <kusmabite@gmail.com>,
 Duy Nguyen <pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBIXWYCOAKGQESM7ZKCA@googlegroups.com Thu Jun 05 11:40:55 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIXWYCOAKGQESM7ZKCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIXWYCOAKGQESM7ZKCA@googlegroups.com>)
	id 1WsUAF-0004T5-MM
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 11:40:51 +0200
Received: by mail-wi0-f186.google.com with SMTP id hi2sf224224wib.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=ulIHXc/ioYa2MogqpyLOUBgD9ZuocZGSKdII+Rr5C70=;
        b=dT74iN6bdvClp92PceW9nh17QhcxFXT6B7lcRu9twlMwJF8KcJjTbzQU6lhMqRdJYY
         CJrkebYPEqrVThVKeizkEp1SgiRmYurpg9Q00ATtWIAiVLaAuxqvwjikdv3X6XaisM5g
         85+f2z7Cpcr9YvQpnOOi0NErQa+Lc+hTx1mbGg1VEVb7PJWEODkYMB9r3aN7xH9tv0mv
         cZyrT6YHtnCczOXF0xTaoh918wtD+p9UBDm4HNqrkHp497+a7rBCWzX4QN/rG0s0Smh9
         6MGK/tN+A/4JMFeem1lUoDPIqWRavNENYiQEIrVDZHboOKKh1WyxOeAgFaWFe1ulMnDj
         tj0g==
X-Received: by 10.181.13.230 with SMTP id fb6mr26544wid.1.1401961251390;
        Thu, 05 Jun 2014 02:40:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.168 with SMTP id gf8ls63137wib.35.gmail; Thu, 05 Jun
 2014 02:40:50 -0700 (PDT)
X-Received: by 10.180.211.234 with SMTP id nf10mr2097133wic.1.1401961250321;
        Thu, 05 Jun 2014 02:40:50 -0700 (PDT)
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com [2a00:1450:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id e12si1225988wiv.1.2014.06.05.02.40.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 02:40:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232 as permitted sender) client-ip=2a00:1450:400c:c05::232;
Received: by mail-wi0-x232.google.com with SMTP id cc10so3051970wib.17
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 02:40:50 -0700 (PDT)
X-Received: by 10.14.251.4 with SMTP id a4mr7710ees.20.1401961250245;
        Thu, 05 Jun 2014 02:40:50 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ci54sm13145923eeb.19.2014.06.05.02.40.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 02:40:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605080317.GA28029@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250827>

Am 05.06.2014 10:03, schrieb Stepan Kasal:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 2 Jun 2010 00:41:33 +0200
>=20
> If HOME is not set, use $HOMEDRIVE$HOMEPATH
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>=20
> Hello Karsten,
> thanks for your explanation.  There are more things to be done, but
> I hope you can ack this patch as a step forward.
>=20

No, not really. Its sure better than introducing a special get_home_directo=
ry(), but it still increases the diff between upstream and msysgit rather t=
han reducing it. The main critique points still remain:

 * $HOME is usually set up correctly before calling git, so this is essenti=
ally dead code (just checked, portable git's git-bash.bat and git-cmd.bat a=
lso do this correctly)

 * even if $HOME was empty, git should setenv("HOME") so that child process=
es can benefit from it (similar to TMPDIR and TERM in current msysgit's min=
gw_startup()). Not setting $HOME because it may hypothetically break child =
processes is a very weak argument, as we always did set $HOME in etc/profil=
e (since the initial version back in 2007).

 * no fallback to $USERPROFILE doesn't work with diconnected home share

If you really have time to spare, I suggest you focus on getting the Unicod=
e patches upstream so that we can progress from there (e.g. move $HOME setu=
p to mingw_startup() so that we can get rid of redundant logic in etc/profi=
le, git-wrapper, git-bash.bat, git-cmd.bat etc.).

> Hello Dscho,
> I hope you can ack this as well: it is basically equivalent with your
> patch, tailored according to current upstream fashion,  ;-)
>=20
> Stepan
>=20
>  compat/mingw.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a0e13bc..e108388 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1181,6 +1181,11 @@ char *mingw_getenv(const char *name)
>  		if (!result)
>  			result =3D getenv_cs("TEMP");
>  	}

else?

> +	if (!result && !strcmp(name, "HOME")) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		strbuf_addf(&buf, "%s%s", getenv_cs("HOMEDRIVE"), getenv_cs("HOMEPATH"=
));

No surplus '/', good!

> +		result =3D strbuf_detach(&buf, NULL);

This leaks memory.

> +	}
>  	return result;
>  }
> =20
>=20

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
