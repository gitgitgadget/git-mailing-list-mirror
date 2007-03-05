From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Mon, 5 Mar 2007 17:44:45 +0200
Message-ID: <20070305154422.GA4798@mellanox.co.il>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>,
   Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
   Linus Torvalds <torvalds@linux-foundation.org>,
   Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-pm-bounces@lists.osdl.org Mon Mar 05 16:47:11 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFOt-0001Zw-Il
	for gll-linux-pm@gmane.org; Mon, 05 Mar 2007 16:47:00 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25Fkmq8029069;
	Mon, 5 Mar 2007 07:46:49 -0800
Received: from dev.mellanox.co.il (dev.mellanox.co.il [194.90.237.44])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25Fkhq8029047
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-pm@lists.osdl.org>; Mon, 5 Mar 2007 07:46:46 -0800
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l25Fi0tS014069;
	Mon, 5 Mar 2007 17:44:00 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation);
	Mon,  5 Mar 2007 17:44:45 +0200
Content-Disposition: inline
In-Reply-To: <20070302080441.GA12785@elte.hu>
User-Agent: Mutt/1.5.11
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-1.896 required=5 tests=AWL,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SUBJECT_BRACKETED
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41453>

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: Re: 2.6.21-rc1: known regressions (part 2)
> =

> =

> * Ingo Molnar <mingo@elte.hu> wrote:
> =

> > I'll try what i've described in the previous mail: mark all bisection =

> > points that do not include f3ccb06f as 'good' - thus 'merging' the =

> > known-bad area with the first known-good commit, and thus eliminating =

> > it from the bisection space.
> =

> this got me quite a bit further:
> =

>  git-bisect start
>  git-bisect bad       01363220f5d23ef68276db8974e46a502e43d01d
>  git-bisect good      f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 =

>  git-bisect fake-good ee404566f97f9254433399fbbcfa05390c7c55f7
>  git-bisect bad       d43a338e395371733a80ec473b40baac5f74d768
>  git-bisect bad       255f0385c8e0d6b9005c0e09fffb5bd852f3b506
>  git-bisect fake-good f99c6bb6e2e9c35bd3dc0b1d0faa28bd6970930d
>  git-bisect fake-good 0187f221e96e3436d552c0c7143f183eb82fb658
>  git-bisect bad       81450b73dde07f473a4a7208b209b4c8b7251d90
>  git-bisect fake-good ef29498655b18d2bfd69048e20835d19333981ab
>  git-bisect fake-good 8a03d9a498eaf02c8a118752050a5154852c13bf
>  git-bisect good      5c95d3f5783ab184f64b7848f0a871352c35c3cf
>  git-bisect good      ecb5f7521a309cb9c5fc0832b9705cd2a03d7d45
>  git-bisect good      0539771d7236b425f285652f6f297cc7939c8f9a

I just confirmed that 0539771d7236b425f285652f6f297cc7939c8f9a
is good for me, too.

>  81450b73dde07f473a4a7208b209b4c8b7251d90 is first bad commit

Going to test that now.

-- =

MST
