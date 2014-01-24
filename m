From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 23:24:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
References: <201401242205.16313.tboegi@web.de> <20140124214023.GB58260@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
    git@vger.kernel.org, zwanzig12@googlemail.com, stefanbeller@googlemail.com, 
    kusmabite@gmail.com, msysgit@googlegroups.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: msysgit+bncBCZPH74Q5YNRBJ6QROLQKGQE3XPOKOY@googlegroups.com Fri Jan 24 23:24:43 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBJ6QROLQKGQE3XPOKOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f56.google.com ([209.85.219.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJ6QROLQKGQE3XPOKOY@googlegroups.com>)
	id 1W6pB2-0007OA-EY
	for gcvm-msysgit@m.gmane.org; Fri, 24 Jan 2014 23:24:40 +0100
Received: by mail-oa0-f56.google.com with SMTP id j17sf704184oag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 24 Jan 2014 14:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=RMnBJ7eULReLWjLnHJ3rY9zKWf3J0jv/jAo9w49uMt0=;
        b=Ud3CO24tcsBDLjyeQWHtdObDp1Yj4RHmTRAWhCQVwkFIuDD3NaNxdAHVAzRgHeXHi8
         rx8+qmxK7Q1+moj/DrEQVLnyllQOuH00Th/q4GVZ4zuEThlV75Ek6FDv4eaEQMoR07Lg
         MFvS8zR/OYtUC23F7gvDjQ/kfMZEbL4GOaqEsHPbKVjn5mufp3XpUJm5qvWfMstvEr6v
         pdt6MCyvUc60AuOLH5nk1AdVBgamHatxlNBTdrtt9rLNpkCCTIXEUlV8eIlYF6GkK2CW
         xzUUjJmBB5cuxNsn/xwQZgq7kGfsAH0RK0oQdIMZ/2z4B6PNFAIGc+bp+xDmepNPZp91
         JXlg==
X-Received: by 10.140.43.227 with SMTP id e90mr237469qga.4.1390602279506;
        Fri, 24 Jan 2014 14:24:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.109.101 with SMTP id k92ls807052qgf.78.gmail; Fri, 24 Jan
 2014 14:24:38 -0800 (PST)
X-Received: by 10.58.154.5 with SMTP id vk5mr6285069veb.32.1390602278844;
        Fri, 24 Jan 2014 14:24:38 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id sq4si391916pbc.0.2014.01.24.14.24.38
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2014 14:24:38 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MUZKF-1Vg3FO0GPL-00RIgL
 for <msysgit@googlegroups.com>; Fri, 24 Jan 2014 23:24:37 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140124214023.GB58260@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ffcvbBOqWHM5/o4LX+X2H6hwa3rM6WL1QDmxyIWzNaw1pwy5/AQ
 jLirbp38wwZHOg+Y0A0lS4O3ZLemhyivM8PETZLp1z7ubBpIloqpf44bwgVwEEQR4YWvNCD
 Al5Q0TG1PEpNz6jLbFSj3jIGk4q/8S+o/qXHF0ZKv5cM0ZTwR/8o2GLMpSTBTUODjo448r4
 mlmlJdp3bfNMtsLu2OUtA==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241047>

Hi Brian,

On Fri, 24 Jan 2014, brian m. carlson wrote:

> On Fri, Jan 24, 2014 at 10:05:14PM +0100, Torsten B=F6gershausen wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index ba66c6e..033b4c2 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -324,6 +324,10 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
> >  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
> >  				chmod(fname_old, statbuffer.st_mode);
> >  			}
> > +			if (!stat(fname, &statbuffer)) {
> > +				statbuffer.st_mode |=3D (S_IWUSR | S_IWGRP | S_IWOTH);
> > +				chmod(fname, statbuffer.st_mode);
> > +			}
>=20
> Are we sure that the file in question can never be a symlink?

On Windows: yes. Otherwise, no.

Having said that, the files in question are files generated by Git, so you
really would have to tamper with things in order to get into trouble.

> Because if it is, we'll end up changing the permissions on the wrong
> file.

In any case, I'd rather change the permissions only when the rename
failed. *And* I feel uncomfortable ignoring the return value...

> In general, I'm wary of changing permissions on a file to suit Windows's
> rename because of the symlink issue and the security issues that can
> result.

I agree on the Windows issue.

> Hard links probably have the same issue.

No, hard links have their own permissions. If you change the permissions
on a hardlink, any other hardlinks to the same content are unaffected.

Ciao,
Johannes

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
For more options, visit https://groups.google.com/groups/opt_out.
