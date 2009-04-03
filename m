From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and  MacOS
 builds
Date: Fri, 3 Apr 2009 15:50:08 +0000
Message-ID: <9d6091530904030850x4eff9e54ga5fb6b13cd036335@mail.gmail.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com> <alpine.DEB.1.00.0904031659290.10279@pacific.mpi-cbg.de>
Reply-To: janos.dev@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Apr 03 17:52:04 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LplgK-0005qf-TF
	for gcvm-msysgit@m.gmane.org; Fri, 03 Apr 2009 17:51:49 +0200
Received: by yw-out-2122.google.com with SMTP id 1so349292ywp.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 03 Apr 2009 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=MXh/Wpyt/5UYXuUAttco6Tf2870AlUa98Ly9GXdRekY=;
        b=BF2QKLHM2eqlUw3ZLi70GceCGx6eWYU9puZIjylO6AhCrJm4MOxFIbs6yBTWCrNalW
         M4AKr+TphxNLutmwItbvSt9KDEHK4amQSxDBJJkqK0LWBBmCGEG47GGB7WNWNntGtHxn
         vKRhlBJEIzEIP3Q2WPDOBQR4sjM5Zwm/kI5v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=VTzQ3FO0sJxycsybrhOX4loIIMbFFAyufytHYIAu+nzfU1reyw+Jxv4o/gZUdrY5Ua
         XLnFK/YahHVmR4EwMdP1lwcVEE7N7CdBl9pocdB1FFi23+xcmpysOZjajYB6stHRwlh/
         LZv7b+ptf+0ECkhTsYyW/PYKLvq7BAfMmVlms=
Received: by 10.150.124.2 with SMTP id w2mr196870ybc.0.1238773813287;
        Fri, 03 Apr 2009 08:50:13 -0700 (PDT)
Received: by 10.176.203.19 with SMTP id a19gr4634yqg.0;
	Fri, 03 Apr 2009 08:50:13 -0700 (PDT)
X-Sender: janos.dev@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.239.10 with SMTP id q10mr13353mur.1.1238773809399; Fri, 03 Apr 2009 08:50:09 -0700 (PDT)
Received: from mail-bw0-f167.google.com (mail-bw0-f167.google.com [209.85.218.167]) by gmr-mx.google.com with ESMTP id 5si82512fge.1.2009.04.03.08.50.08; Fri, 03 Apr 2009 08:50:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of janos.dev@gmail.com designates 209.85.218.167 as permitted sender) client-ip=209.85.218.167;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of janos.dev@gmail.com designates 209.85.218.167 as permitted sender) smtp.mail=janos.dev@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by bwz11 with SMTP id 11so1031975bwz.23 for <msysgit@googlegroups.com>; Fri, 03 Apr 2009 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=UvH/0dsMH2i+n70mC03e6Ws0sz2KprRnBgSVF79SPMY=; b=eoJpKikypTl5S/3lhWQLM0A7FWxarvPd+az8eR5Ej/V/mlHF2IG44xk8x9qJQ6nifR v5Ofpp4qJ5rGCdcXKNmO5CUobF2ze5aFW0jOpKZTmcJ+zje/Bz+0WMoQ6Rm0KfXZc6qH 2/X8ZKy6Unva8xbYC7BCFq4Q/Vh1KNgm6vzIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=PHGvXrXTEtk5Lj/DHCQbP33CSq9OZXih4ipxbOlkZurmz4mERSI97LB3XTkQ6wdj7s ArZKdpP1yk1VYz+gBqGaTCOxNW/tqaznDIO2uqN/kKSvWuT+rpuuB4ngqg3ssBozN5ja dpXnwWXphCgYO0vyTSREfPkzXWxjWMtiJBck4=
Received: by 10.204.57.138 with SMTP id c10mr459287bkh.56.1238773808198; Fri,  03 Apr 2009 08:50:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904031659290.10279@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115539>


>
> Hi,
>
> On Fri, 3 Apr 2009, Marius Storm-Olsen wrote:
>
>> The standard allocator on Windows is pretty bad prior to Windows Vista,
>> and nedmalloc is better than the modified dlmalloc provided with newer
>> versions of the MinGW libc.
>>
>> Note that both Windows and MacOSX need to have an implementation of
>> strdup, which I added at the end of nedmalloc.c, to ensure that strdup
>> use the same heap. So, setting USE_NED_ALLOCATION =3D YesPlease will als=
o
>> add this function reimplementation, unless you define
>> NEDMALLOC_DONT_OVERRIDE_STRDUP.
>>
>> NedMalloc stats in Git
>> ----------------------
>> =C2=A0 All results are the best result out of 3 runs. The
>> =C2=A0 benchmarks have been done on different hardware, so
>> =C2=A0 the repack times are not comparable.
>>
>> =C2=A0 These benchmarks are all based on 'git repack -adf'
>> =C2=A0 on the Linux kernel.
>>
>> =C2=A0 XP
>> =C2=A0 -----------------------------------------------
>> =C2=A0 MinGW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Threads =
=C2=A0Total Time =C2=A0 Speed
>> =C2=A0 -----------------------------------------------
>> =C2=A0 3.4.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1T) =C2=A000:12:28.422
>> =C2=A0 3.4.2 =C2=A0 =C2=A0 + nedmalloc =C2=A0(1T) =C2=A000:07:25.437 1.6=
8x
>>
>> =C2=A0 3.4.5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1T) =C2=A000:12:20.718
>> =C2=A0 3.4.5 =C2=A0 =C2=A0 + nedmalloc =C2=A0(1T) =C2=A000:07:24.809 1.6=
7x
>>
>> =C2=A0 4.3.3-tdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1T) =
=C2=A000:12:01.843
>> =C2=A0 4.3.3-tdm + nedmalloc =C2=A0(1T) =C2=A000:07:16.468 1.65x
>>
>> =C2=A0 4.3.3-tdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2T) =
=C2=A000:07:35.062
>> =C2=A0 4.3.3-tdm + nedmalloc =C2=A0(2T) =C2=A000:04:57.874 1.54x
>
> Wow! =C2=A0That is impressive.

indeed, haven't time to test it myself currently tho :-( i hope
someone can confirm this massive performance boost and that this patch
makes it into msysgit very soon. thanks for the work :-)
