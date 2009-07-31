From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 06:27:07 -0700 (PDT)
Message-ID: <m3d47hrniw.fsf@localhost.localdomain>
References: <20090726232154.29594.qmail@science.horizon.com>
	<20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 15:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWs8h-0001cL-RA
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 15:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbZGaN1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 09:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbZGaN1L
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 09:27:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61738 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZGaN1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 09:27:10 -0400
Received: by bwz19 with SMTP id 19so1190137bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/+bpSBDrysSQSi8U2/Lzko8jRr5hg6fmisNPUUE/jIM=;
        b=X4kc0HvdyeWM5jjCAKkQRfsrDcrZrbE946SGEqjN8gG6rZ2GPvQvbIHcwDc9F8dtdK
         VKWrtUg3alvHLZvej3oUrkc0ZXdPP6WrlXe6sOvz5zSm4r+DBTcD97ybnGZAkiIWXmCq
         Fli1fhTCfZ4MSjrx/IMjqDoMYif951jhHOM7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fFNOml69F3ElUz667bffT6Hu/OlhmrPmf7yMQaOtMVi4uCxF2E3nvUVwEaudZQNp6W
         rGEyJ4+hzOHe11ebadNi9LjOlfnftnNsFLKX4Tk1DgqmSpaPK8a4oD4+xyjma7x0vot6
         pusuTEBduLkwiA+pwDYzhOYjq5+sCnnNTl42Y=
Received: by 10.204.63.20 with SMTP id z20mr2086935bkh.34.1249046828045;
        Fri, 31 Jul 2009 06:27:08 -0700 (PDT)
Received: from localhost.localdomain (abvt17.neoplus.adsl.tpnet.pl [83.8.217.17])
        by mx.google.com with ESMTPS id d13sm676987fka.2.2009.07.31.06.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 06:27:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6VDR4wo025444;
	Fri, 31 Jul 2009 15:27:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6VDR3cc025441;
	Fri, 31 Jul 2009 15:27:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124560>

"George Spelvin" <linux@horizon.com> writes:
> After studying Andy Polyakov's optimized x86 SHA-1 in OpenSSL, I've
> got a version that's 1.6% slower on a P4 and 15% faster on a Phenom.
> I'm curious about the performance on other CPUs I don't have access to,
> particularly Core 2 duo and i7.
> 
> Could someone do some benchmarking for me?  Old (486/Pentium/P2/P3)
> machines are also interesting, but I'm optimizing for newer ones.

----------
$ [time] ./586test 
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 5.376325 s

real    0m5.384s
user    0m5.108s
sys     0m0.008s

500000000 bytes: 5.367261 s

5.09user 0.00system 0:05.38elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+378minor)pagefaults 0swaps

----------
$ [time] ./x86test 
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 5.312238 s

real    0m5.325s
user    0m5.060s
sys     0m0.008s

500000000 bytes: 5.323783 s

5.06user 0.00system 0:05.34elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+377minor)pagefaults 0swaps

==========
System:
$ uname -a
Linux roke 2.6.14-11.1.aur.2 #1 Tue Jan 31 16:05:05 CET 2006 \
 i686 athlon i386 GNU/Linux

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) processor
stepping	: 2
cpu MHz		: 1000.188
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 mtrr pge \
 mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2002.43

$ free
             total       used       free     shared    buffers     cached
Mem:        515616     495812      19804          0       6004     103160
-/+ buffers/cache:     386648     128968
Swap:      1052248     279544     772704

-- 
Jakub Narebski
Poland
ShadeHawk on #git
