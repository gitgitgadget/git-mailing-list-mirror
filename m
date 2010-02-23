From: Kirill <kirillathome@gmail.com>
Subject: Re: [GITK PATCH 2/3] gitk: support path filters even in 
	subdirectories
Date: Tue, 23 Feb 2010 14:37:37 -0500
Message-ID: <f579dd581002231137t71bb034fl429fd03a2c0d681c@mail.gmail.com>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>
	 <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>
	 <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>
	 <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Pat Thoyts <patthoyts@googlemail.com>, Paul Mackerras <paulus@samba.org>, msysgit@googlegroups.com, 
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3hS6ESwwJB4Mrpypssh0ovtlnthps.jvttz5znp0nvvnslnyv1wz.jvt@groups.bounces.google.com Tue Feb 23 20:38:01 2010
Return-path: <3hS6ESwwJB4Mrpypssh0ovtlnthps.jvttz5znp0nvvnslnyv1wz.jvt@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f139.google.com ([209.85.210.139])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3hS6ESwwJB4Mrpypssh0ovtlnthps.jvttz5znp0nvvnslnyv1wz.jvt@groups.bounces.google.com>)
	id 1Nk0a0-00018S-Uq
	for gcvm-msysgit@m.gmane.org; Tue, 23 Feb 2010 20:38:01 +0100
Received: by mail-yx0-f139.google.com with SMTP id 3sf1590354yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Feb 2010 11:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=fV5fofclxjH+/3dDDwgUgD1B6Cutww14JVHvZBbqIV4=;
        b=zjGDEbBjQ03cPdxHA/WtQwW7Str8rqoSsUFiTXxMtkLBgEEdVxd6jAs5Vll1K5Cs0y
         i3kfMIiqPDC6Ng7hVEDm3BlUMN4HpCsJ6llfdh1yDcOCZzIR/kf1ytixakKDOvvr8UI3
         KZgZAFGY60fUy/j4SkMjaSCSy9tIFzRp3unsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=JG8FEuJIRi7PYV2ZZHS7pQTTQHdZ9KN7JxzRFbZS9jof+56xo0hz42NsjLFDPiz3f9
         JoCv09rjpDhLfGs//uqt57oiUoGwTPoMH849Ijc4XtJEBU7077dXl7tZBeeH53ODU6h7
         Eq91H1GootoWdULqUvuLRvolLR5X+4LIVMJp4=
Received: by 10.150.188.6 with SMTP id l6mr49186ybf.82.1266953861647;
        Tue, 23 Feb 2010 11:37:41 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.44.133 with SMTP id a5ls25703ebf.1.p; Tue, 23 Feb 2010 
	11:37:40 -0800 (PST)
Received: by 10.213.63.75 with SMTP id a11mr1339892ebi.19.1266953860168;
        Tue, 23 Feb 2010 11:37:40 -0800 (PST)
Received: by 10.213.63.75 with SMTP id a11mr1339891ebi.19.1266953860145;
        Tue, 23 Feb 2010 11:37:40 -0800 (PST)
Received: from mail-ew0-f216.google.com (mail-ew0-f216.google.com [209.85.219.216])
        by gmr-mx.google.com with ESMTP id 11si55666ewy.1.2010.02.23.11.37.39;
        Tue, 23 Feb 2010 11:37:39 -0800 (PST)
Received-SPF: pass (google.com: domain of kirillathome@gmail.com designates 209.85.219.216 as permitted sender) client-ip=209.85.219.216;
Received: by ewy8 with SMTP id 8so369551ewy.32
        for <msysgit@googlegroups.com>; Tue, 23 Feb 2010 11:37:39 -0800 (PST)
Received: by 10.216.91.18 with SMTP id g18mr2423790wef.203.1266953858313; Tue, 
	23 Feb 2010 11:37:38 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kirillathome@gmail.com designates 209.85.219.216 as permitted 
	sender) smtp.mail=kirillathome@gmail.com; dkim=pass (test mode) 
	header.i=@gmail.com
X-Original-Sender: kirillathome@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/69f026c732a13b2
X-Message-Url: http://groups.google.com/group/msysgit/msg/fe0d7a7d38947a82
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140825>

Hi,

Dscho, at first, thank you so much for working on the issue!
In general the series work. At least, it passes my limited testing
from the original message. However...

On Tue, Feb 23, 2010 at 12:10 PM, Johannes Schindelin wrote:
>
> Even when running inside a subdirectory, "gitk HEAD -- ." should work.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> =A0gitk-git/gitk | =A0 =A06 +++++-
> =A01 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 553922f..bad9ebc 100644
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -7340,9 +7340,12 @@ proc startdiff {ids} {
> =A0}
>
> =A0proc path_filter {filter name} {
> + =A0 =A0global pathprefix
> =A0 =A0 foreach p $filter {
> =A0 =A0 =A0 =A0if {$p =3D=3D "."} {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set p $pathprefix
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set p $pathprefix$p
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0set l [string length $p]
> =A0 =A0 =A0 =A0if {[string index $p end] eq "/"} {
> @@ -11585,6 +11588,7 @@ readrefs
>
> =A0if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {=
}} {
> =A0 =A0 # create a view for the files/dirs specified on the command line
> + =A0 =A0set pathprefix [exec git rev-parse --show-prefix]
I believe the fact that pathprefix is set only under several
conditions, the invocation without arguments is broken.

My .02

--
Kirill.
