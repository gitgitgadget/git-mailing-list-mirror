From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: larger default page sizes...
Date: Wed, 26 Mar 2008 02:16:07 +0100
Message-ID: <998d0e4a0803251816q5653ce6fj8931fe93cccac85f@mail.gmail.com>
References: <998d0e4a0803251647i2abefe96t34ec4ad6706afcfd@mail.gmail.com> 	 <998d0e4a0803251800w25a13df3o9396ee983eaba4e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "David Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,  	git@vger.kernel.org, GCC <gcc@gcc.gnu.org>
X-From: gcc-return-145591-gcc=m.gmane.org@gcc.gnu.org Wed Mar 26 02:17:18 2008
Return-path: <gcc-return-145591-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1JeKGJ-00089q-6L
	for gcc@gmane.org; Wed, 26 Mar 2008 02:17:07 +0100
Received: (qmail 8111 invoked by alias); 26 Mar 2008 01:16:27 -0000
Received: (qmail 8103 invoked by uid 22791); 26 Mar 2008 01:16:27 -0000
X-Spam-Check-By: sourceware.org
Received: from wx-out-0506.google.com (HELO wx-out-0506.google.com) (66.249.82.228)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 26 Mar 2008 01:16:09 +0000
Received: by wx-out-0506.google.com with SMTP id s18so3796748wxc.14         for <gcc@gcc.gnu.org>; Tue, 25 Mar 2008 18:16:07 -0700 (PDT)
Received: by 10.70.12.2 with SMTP id 2mr11261810wxl.78.1206494167745;         Tue, 25 Mar 2008 18:16:07 -0700 (PDT)
Received: by 10.70.77.16 with HTTP; Tue, 25 Mar 2008 18:16:07 -0700 (PDT)
In-Reply-To: <998d0e4a0803251800w25a13df3o9396ee983eaba4e0@mail.gmail.com>
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78239>

On 2008/3/26, J.C. Pizarro <jcpiza@gmail.com> i wrote:
 > On Tue, 25 Mar 2008 16:22:44 -0700 (PDT), David Miller wrote:
 >  > > On Mon, 24 Mar 2008, David Miller wrote:
 >  > >
 >  > > > There are ways to get large pages into the process address space for
 >  > > > compute bound tasks, without suffering the well known negative side
 >  > > > effects of using larger pages for everything.
 >  > >
 >  > > These hacks have limitations. F.e. they do not deal with I/O and
 >  > > require application changes.
 >  >
 >  > Transparent automatic hugepages are definitely doable, I don't know
 >  > why you think this requires application changes.
 >  >
 >  > People want these larger pages for HPC apps.
 >
 >  But there is a general problem of larger pages in systems that
 >  don't support them natively (in hardware) depending in how it's
 >  implemented the memory manager in the kernel:
 >
 >    "Doubling the soft page size implies
 >       halfing the TLB soft-entries in the old hardware".
 >
 >    "x4 soft page size=> 1/4 TLB soft-entries, ... and so on."
 >
 >  Assuming one soft double-sized page represents 2 real-sized pages,
 >  one replacing of one soft double-sized page implies replacing
 >  2 TLB's entries containing the 2 real-sized pages.
 >
 >  The TLB is very small, its entries are around 24 entries aprox. in
 >  some processors!.
 >
 >  Assuming soft 64 KiB page using real 4 KiB pages => 1/16 TLB soft-entries.
 >  If the TLB has 24 entries then calculating 24/16=1.5 soft-entries,
 >    the TLB will have only 1 soft-entry for soft 64 KiB pages!!! Weird!!!
 >
 >  The normal soft sizes are 8 KiB or 16 KiB for non-native
processors, not more.
 >   So, the TLB of 24 entries of real 4 KiB will have 12 or 6
 >  soft-entries respect.


The problem is that x86 and x64 is a "crap" when we want larger page sizes
 (as 8, 16, 32 or 64 KiB) for HPC but not unusual excesive huge pages
 (2, 4, 1024 MiB).

 Stop the buying of the current PCs or Laptops, and wait until the well made
 PCs or Laptops "Intel Code Quad 3" or "AMD Athlon AM3" with the following
 cleaner features (lesser gates and more liable circuitry):
 1. Instructions x86-64-II only to address usual cheaper 4 or 8 GiB of DDR RAM,
    but changed the hierarchy of bytecodes of x86-64 for better performance.
 2. Removed old 16-bit 8086 and old 32-bit 80386 instructions.
 3. Removed unusual BCD instructions too.
 4. Removed PAE and Hugepages of old 32-bit 80386 instructions.
 5. Configurable TLB to only 8, 16, 32 and 64 KiB pages.
 6. Configurable 3-level or 4-level MMU depending in the cfg'ble page sizes.
 7. Removed 32-bit and 80-bit float points.
 8. Added 64-bit as float point and 128-bit as double point, IEEE754.
 9. Removed MMX/3DNow+ instructions.
 10. Integrated SSEx instructions (auto saved/restrored to/from task's stack).
 11. Improved PIC (Position Independent Code) for shared libraries.
 12. Improved hardware x86-64 virtualization.
 13. Improved hardware x86-64 debuggability.
 14. Improved CPU counters and timestampers in variabled-frequencies.
 15. Realtime UTC (leap ctrl,DST,tz) clockers in ns for CPU-profilings.
 16. Improved flushers (caches, TLB, MMU, ...).
 17. Improved hardware futexes, semaphores, signals, .. for multicores.
 18. MOESI protocol for multicores in SMPs & clusters.
 19. Better integrated DMAs in processors.
 20. Faster buses not always in fixed frequencies as said in the specs.
 21. Reliable exceptions's handlings in out-of-order termination architectures.
 22. More capabilities for soft multi-threading of the O.S. in SMPs & clusters.
 23. More capabilities for processes's migrating of the O.S. in SMPs & clusters.
 24. More capabilities for JIT/AOT emulators of different hw as Qemu, Java, ..
 25. And more acknowledge of connected devices as ACPI, e820, ...

 I don't see reasons of why Intel/AMD follow to release new x86-compatible
 processors when they follow still being a crap in the reasonable practiques.

I can't be sorry of the error in Mail Delivery Subsystem of LKML when i was
terminating soon of my comments.
