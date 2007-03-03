From: Avi Kivity <avi@qumranet.com>
Subject: Re: [patch] KVM: T60 resume fix
Date: Sat, 03 Mar 2007 10:22:13 +0200
Message-ID: <45E93035.2070509@qumranet.com>
References: <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<20070302113920.GB9367@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>,
   Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>,
   Thomas Gleixner <tglx@linutronix.de>,
   Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
   git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: linux-pm-bounces@lists.osdl.org Sat Mar 03 09:22:39 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNPVm-0008Ff-M6
	for gll-linux-pm@gmane.org; Sat, 03 Mar 2007 09:22:39 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l238MSq8019668;
	Sat, 3 Mar 2007 00:22:28 -0800
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l238MPq7019660
	for <linux-pm@lists.osdl.org>; Sat, 3 Mar 2007 00:22:25 -0800
Received: from mis011-2.exch011.intermedia.net ([64.78.21.223]) by
	mis011-2.exch011.intermedia.net with Microsoft
	SMTPSVC(6.0.3790.1830); Sat, 3 Mar 2007 00:22:20 -0800
Received: from [87.69.86.53] ([87.69.86.53]) by
	mis011-2.exch011.intermedia.net over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Sat, 3 Mar 2007 00:22:19 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <20070302113920.GB9367@mellanox.co.il>
X-OriginalArrivalTime: 03 Mar 2007 08:22:20.0174 (UTC)
	FILETIME=[0FD452E0:01C75D6D]
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-3.815 required=5 tests=AWL,MIME_QP_LONG_LINE,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SPF_PASS,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-BeenThere: linux-pm@lists.osdl.org
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Linux power management <linux-pm.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41276>

Michael S. Tsirkin wrote:
>> Quoting Ingo Molnar <mingo@elte.hu>:
>> Subject: [patch] KVM: T60 resume fix
>> From: Ingo Molnar <mingo@elte.hu>
>>
>> my T60 laptop does not resume correctly due to KVM attempting to send an =

>> IPI to a CPU that might be down (or not up yet). (Doing so also triggers =

>> the send_IPI_mask_bitmask() warning in arch/i386/kernel/smp.c, line =

>> 732.)
>>
>> with this fix applied my laptop does not hang during resume.
>>
>> [ KVM will have to disable/enable virtualization on the CPU itself that
>>   goes down / comes up, not via an IPI sent from the requesting CPU. ]
>>
>> Signed-off-by: Ingo Molnar <mingo@elte.hu>
>>     =

>
> Since I don't normally have kvm loaded, this patch is unlikely
> to help me, is that right?
>
>   =


That is correct.


-- =

Do not meddle in the internals of kernels, for they are subtle and quick to=
 panic.
