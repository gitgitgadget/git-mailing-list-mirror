From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: [PATCH v2] repack.c: Use move_temp_to_file()
 instead of rename()
Date: Sun, 02 Feb 2014 16:17:08 +0100
Message-ID: <52EE6174.1050401@web.de>
References: <201402021609.56984.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>, 
 git@vger.kernel.org, zwanzig12@googlemail.com, 
 stefanbeller@googlemail.com, kusmabite@gmail.com, 
 Johannes.Schindelin@gmx.de, msysgit@googlegroups.com
X-From: msysgit+bncBCUZ3EUT2ADRB5WCXGLQKGQEV64Q6MA@googlegroups.com Sun Feb 02 16:17:12 2014
Return-path: <msysgit+bncBCUZ3EUT2ADRB5WCXGLQKGQEV64Q6MA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f185.google.com ([209.85.215.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRB5WCXGLQKGQEV64Q6MA@googlegroups.com>)
	id 1W9ynH-0002Cm-I6
	for gcvm-msysgit@m.gmane.org; Sun, 02 Feb 2014 16:17:11 +0100
Received: by mail-ea0-f185.google.com with SMTP id r15sf704510ead.12
        for <gcvm-msysgit@m.gmane.org>; Sun, 02 Feb 2014 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=svZntMUQG2T8L0/VJ5kAfg8Xp2qRlH2WHGNgN9HOkqE=;
        b=OezIzRphGShEXjqbPDw2Kopieufh606oTLfg6RrqEkozZSd+V5sNBJFEZ3Pf3bvZ+h
         DIeszLAvANW9T5urJWc6bpG7gHE5VAq+p3ab7D2D1PGM12yy3BAM2hrEN827mlVcu+3S
         wRomJ8zEA43OuXosnRe5qFWQviKw3ZmCER3A5nXQQoYWpmopojuxQ0OLOTsKEHgcCuL3
         yOHsF4X/uuUh/7OU674uTbJJx1F06Y5GVDhnsR3nbaHcq0ADvq65WuHXHbQxC9YmuRnu
         JmjuFGawJcsSt6VwoJkVN6Ikok3+Oxwaq1ycL/ZTKed0JU2pprvnIGVKGA0PV3UNB+3t
         rD4g==
X-Received: by 10.152.198.165 with SMTP id jd5mr9208lac.8.1391354231230;
        Sun, 02 Feb 2014 07:17:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.7.194 with SMTP id de2ls267007lad.5.gmail; Sun, 02 Feb
 2014 07:17:10 -0800 (PST)
X-Received: by 10.112.27.138 with SMTP id t10mr12941870lbg.19.1391354230403;
        Sun, 02 Feb 2014 07:17:10 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.14])
        by gmr-mx.google.com with ESMTPS id f47si5836368eem.0.2014.02.02.07.17.10
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2014 07:17:10 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.14 as permitted sender) client-ip=212.227.15.14;
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LjJH1-1VXMK23Vk7-00dZjW for
 <msysgit@googlegroups.com>; Sun, 02 Feb 2014 16:17:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <201402021609.56984.tboegi@web.de>
X-Provags-ID: V03:K0:0AqEwph3qs1wa2fm2xjSxIU/O9yvyLxlEx8FO8mQqDTJ5Z9sT+1
 An3ugEndCRMbssbORR7hHHzhkP0gX2mTjS5GaOD6LPWtP3geHdLGinueBXCMrwS9xOVokLP
 765WHXiBJbGLMvd/ZR40LHm6tW8Bdcdk5pRcEflqdwWfvFZnZ+9nWJjj9x86tUWCNA5crjN
 z5x5bQIThUYYwaDSrbg1w==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.14 as permitted sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241373>

(It seems as if the mail went only to Junio, sorry)
On 2014-02-02 16.09, Torsten B=C3=B6gershausen wrote:
> On 2014-01-29 19.17, Junio C Hamano wrote:
>> But after a closer inspection, I no longer think that hunk is an
>> improvement.  These new packfiles were created by pack-objects,
>> which finishes each packfile it produces by calling
>> finish_tmp_packfile(), and that is where adjust_shared_perm()
>> happens already.  As far as "pack-objects" that was called from
>> "repack" is concerned, these new packfiles are not "temporary"; they
>> are finished product.  It may be OK to remove them as part of
>> "rewind back to the original state, as a later phase of repack
>> failed" if we saw a failure (but note that the original
>> "git-repack.sh" didn't), but a plain vanilla rename(2) without any
>> frills is what we want to happen to them.
> Thanks for deeper inspection, I now suspect the root cause to be here:
>
> -- >8 --
> Subject: [PATCH v3] repack.c: Rename and unlink pack file if it exists
>
> This comment in builtin/repack.c:
>   * First see if there are packs of the same name and if so
>   * if we can move them out of the way (this can happen if we
>   * repacked immediately after packing fully.
> indicates that when a repo was fully repacked, and is repacked again,
> we may run into the situation that "new" packfiles have the name
> (and content) as already existing ones.
>
> The logic is to rename the existing ones into filename like "old-XXX",
> create the new ones and remove the "old-" ones.
> When something went wrong, a manual roll-back could be done be renaming
> the "old-" files.
>
> The renaming into "old-" did not work as designed, because file_exists()
> was done on the wrong file name.
> This could give problems for a repo on a network share under Windows,
> as reported by Jochen Haag <zwanzig12@googlemail.com>
>
> Solution:
> Create the right file name, like this:
>   fname =3D mkpathdup("%s/pack-%s%s", packdir,
> and when removing the old-files:
>   fname_old =3D mkpath("%s/old-%s%s",
>
> Rename the variables to match what they are used for:
> fname, fname_old and fname_tmp
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  builtin/repack.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 6284846..de69401 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -258,7 +258,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
>  			char *fname, *fname_old;
> -			fname =3D mkpathdup("%s/%s%s", packdir,
> +			fname =3D mkpathdup("%s/pack-%s%s", packdir,
>  						item->string, exts[ext]);
>  			if (!file_exists(fname)) {
>  				free(fname);
> @@ -314,33 +314,33 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
>  	/* Now the ones with the same name are out of the way... */
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
> -			char *fname, *fname_old;
> +			char *fname, *fname_tmp;
>  			struct stat statbuffer;
>  			fname =3D mkpathdup("%s/pack-%s%s",
>  					packdir, item->string, exts[ext]);
> -			fname_old =3D mkpathdup("%s-%s%s",
> +			fname_tmp =3D mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext]);
> -			if (!stat(fname_old, &statbuffer)) {
> +			if (!stat(fname_tmp, &statbuffer)) {
>  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -				chmod(fname_old, statbuffer.st_mode);
> +				chmod(fname_tmp, statbuffer.st_mode);
>  			}
> -			if (rename(fname_old, fname))
> -				die_errno(_("renaming '%s' failed"), fname_old);
> +			if (rename(fname_tmp, fname))
> +				die_errno(_("renaming '%s' into '%s' failed"), fname_tmp, fname);
>  			free(fname);
> -			free(fname_old);
> +			free(fname_tmp);
>  		}
>  	}
> =20
>  	/* Remove the "old-" files */
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
> -			char *fname;
> -			fname =3D mkpath("%s/old-pack-%s%s",
> +			char *fname_old;
> +			fname_old =3D mkpath("%s/old-%s%s",
>  					packdir,
>  					item->string,
>  					exts[ext]);
> -			if (remove_path(fname))
> -				warning(_("removing '%s' failed"), fname);
> +			if (remove_path(fname_old))
> +				warning(_("removing '%s' failed"), fname_old);
>  		}
>  	}
> =20

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
