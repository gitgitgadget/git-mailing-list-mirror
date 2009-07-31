From: Brian Ristuccia <brian@ristuccia.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 09:27:02 -0400
Message-ID: <20090731132702.GY12813@osiris.978.org>
References: <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Spelvin <linux@horizon.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 15:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWs8h-0001cL-3Z
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 15:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZGaN1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 09:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbZGaN1F
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 09:27:05 -0400
Received: from osiris.978.org ([72.70.36.11]:46882 "HELO osiris.978.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752585AbZGaN1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 09:27:05 -0400
Received: (qmail 22949 invoked by uid 1000); 31 Jul 2009 09:27:04 -0400
Received: by osiris.978.org (hashcash-sendmail, from uid 1000);
	Fri, 31 Jul 2009 09:27:02 -0400
Content-Disposition: inline
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
User-Agent: Mutt/1.3.28i
X-Hashcash: 1:21:090731:git@vger.kernel.org::gHN4+rWrmD+HnXEU:000000000000000000
	000000000000000000000000DE3K
X-Hashcash: 1:21:090731:linux@horizon.com::ZwGZY2lOLtcj8/Ez:00000000000000000000
	000000000000000000000000013Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124559>

The revised code is faster on Intel Atom N270 by around 15% (results below
typical of several runs):

$ ./586test ; ./x86test 
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 4.981760 s
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 4.323324 s

$ cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N270   @ 1.60GHz
stepping	: 2
cpu MHz		: 800.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc
arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2 ssse3 xtpr pdcm
lahf_lm
bogomips	: 3191.59
clflush size	: 64
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N270   @ 1.60GHz
stepping	: 2
cpu MHz		: 800.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc
arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2 ssse3 xtpr pdcm
lahf_lm
bogomips	: 3191.91
clflush size	: 64
power management:

-- 
Brian Ristuccia
brian@ristuccia.com
