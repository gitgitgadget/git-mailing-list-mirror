From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 11:05:09 -0400
Message-ID: <eaa105840907310805x452f6b09tf602672359bd1aac@mail.gmail.com>
References: <20090726232154.29594.qmail@science.horizon.com>
	 <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWtfl-0005hX-Cw
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZGaPFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 11:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbZGaPFL
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:05:11 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50850 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZGaPFK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 11:05:10 -0400
Received: by ewy10 with SMTP id 10so1570813ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Mb3abqcDc9VB8/xKS5NfLL59F7NUK0eJdyDtazfjgfc=;
        b=tzoaMfeYlIgG0LmrSlU0nlZfmV9cZp/1+ptGJuMwuaJQgzVBHV35Tb1wtUtTFDtYkN
         fS5cWDJ/AE75cr84HARJhOQyB5OISeiTYN9gDCJ+fnGwUj93uqyAJBU8A1S8zsU5M28s
         a4/9GC5EC5HWwFYNM0kjS/kXftip8IHDLxGSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AJhfe4T1mD8MgKLPnFazY6LxV34U6uRkhBvOf2JOFij41M1CUCYxx2XBmU+E5QAGEG
         Xs5VtKAh6zE/FI4blTxJuGlcQkTTyMDlhYu0ya8BO4gtS4EEEMIHz9Lz674MB4zFI9Ot
         pOFLze7LT3OAO+b1pIU2XJQgmf1F8DNZMU/JQ=
Received: by 10.210.39.8 with SMTP id m8mr1054650ebm.11.1249052709523; Fri, 31 
	Jul 2009 08:05:09 -0700 (PDT)
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
X-Google-Sender-Auth: e13bf70644c8d814
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124566>

On Fri, Jul 31, 2009 at 6:46 AM, George Spelvin wrote:
> Could someone do some benchmarking for me? =A0Old (486/Pentium/P2/P3)
> machines are also interesting, but I'm optimizing for newer ones.

The new code appears to be marginally faster on a Pentium 3 Xeon:

Best of five runs:
586test: 11.658661 s
x86test: 11.209024 s

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 547.630
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.12
clflush size    : 32
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 547.630
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1095.37
clflush size    : 32
power management:
