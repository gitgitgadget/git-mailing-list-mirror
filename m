From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:26:44 +0200
Message-ID: <85ejfwi3gr.fsf@lola.goethe.zz>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <feud8j$kdg$1@ger.gmane.org>
	<20071015173832.GB2966@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, make-w32@gnu.org,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 22:23:35 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVZi-0003dC-TL
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 21:26:03 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhVZb-0004wf-HT
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 15:25:55 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhVZW-0004vD-Lt
	for make-w32@gnu.org; Mon, 15 Oct 2007 15:25:50 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhVZV-0004v1-8O
	for make-w32@gnu.org; Mon, 15 Oct 2007 15:25:50 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhVZV-0004uy-3n
	for make-w32@gnu.org; Mon, 15 Oct 2007 15:25:49 -0400
Received: from fencepost.gnu.org ([140.186.70.10])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>) id 1IhVZU-0001Gv-Tq
	for make-w32@gnu.org; Mon, 15 Oct 2007 15:25:49 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IhVZT-0005hn-U8; Mon, 15 Oct 2007 15:25:48 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 139961C4D4B3; Mon, 15 Oct 2007 21:26:44 +0200 (CEST)
In-Reply-To: <20071015173832.GB2966@steel.home> (Alex Riesen's message of
	"Mon\, 15 Oct 2007 19\:38\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-detected-kernel: by monty-python.gnu.org: Linux 2.6, seldom 2.4 (older, 4)
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61030>

Alex Riesen <raa.lkml@gmail.com> writes:

> Michael Gebetsroither, Mon, Oct 15, 2007 02:46:11 +0200:
>> > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
>> >   can be not the same, depending on what current "drive" is) and
>> >   multi-cwd, which hasn't had formed itself into a problem yet, but
>> >   surely will
>> 
>> Thats true for linux too.
>> /a/b/c and /a/b/c can be 2 totally different files depending on the vfs
>> namespace you are one.
>
> No it is not. A process will always see the same filesystem object
> under the same path at the any given time (IOW, you can't have many
> namespaces active at the same time).

dak@lola:/home/tmp/emacs$ mkdir -p /tmp/a/b
dak@lola:/home/tmp/emacs$ cd /tmp/a/b
dak@lola:/tmp/a/b$ sudo mount --bind /usr /tmp/a
Password:
dak@lola:/tmp/a/b$ command pwd
/tmp/a/b
dak@lola:/tmp/a/b$ ls -l
total 0
dak@lola:/tmp/a/b$ ls -l /tmp/a/b
ls: /tmp/a/b: No such file or directory
dak@lola:/tmp/a/b$ 

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
