From: Nix <nix@esperi.org.uk>
Subject: Re: Git and GCC
Date: Sat, 15 Dec 2007 00:18:37 +0000
Message-ID: <877ijg6c9u.fsf@hades.wkstn.nix>
References: <998d0e4a0712071821o520a75c4lbcaae92256071f48@mail.gmail.com> 	<Pine.LNX.4.64.0712081223070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.C. Pizarro" <jcpiza@gmail.com>,         Linus Torvalds <torvalds@linux-foundation.org>,         David Miller <davem@davemloft.net>, gcc@gcc.gnu.org,         git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: gcc-return-143003-gcc=m.gmane.org@gcc.gnu.org Sat Dec 15 01:19:17 2007
Return-path: <gcc-return-143003-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J3KkN-0004Vx-B3
	for gcc@gmane.org; Sat, 15 Dec 2007 01:19:15 +0100
Received: (qmail 16943 invoked by alias); 15 Dec 2007 00:18:55 -0000
Received: (qmail 16930 invoked by uid 22791); 15 Dec 2007 00:18:54 -0000
X-Spam-Check-By: sourceware.org
Received: from 41-052.adsl.zetnet.co.uk (HELO mail.esperi.org.uk) (194.247.41.52)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 15 Dec 2007 00:18:46 +0000
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18]) 	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id lBF0IcTq015582; 	Sat, 15 Dec 2007 00:18:38 GMT
Received: (from nix@localhost) 	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id lBF0Ibdq021331; 	Sat, 15 Dec 2007 00:18:37 GMT
Emacs: indefensible, reprehensible, and fully extensible.
In-Reply-To: <Pine.LNX.4.64.0712081223070.27959@racer.site> (Johannes Schindelin's message of "Sat, 8 Dec 2007 12:24:00 +0000 (GMT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-sonic.net-Metrics: hades 1117; Body=6 Fuz1=6 Fuz2=6
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68363>

On 8 Dec 2007, Johannes Schindelin said:

> Hi,
>
> On Sat, 8 Dec 2007, J.C. Pizarro wrote:
>
>> On 2007/12/07, "Linus Torvalds" <torvalds@linux-foundation.org> wrote:
>>
>> > SHA1 is almost totally insignificant on x86. It hardly shows up. But 
>> > we have a good optimized version there.
>> 
>> If SHA1 is slow then why dont he contribute adding Haval160 (3 rounds) 
>> that it's faster than SHA1? And to optimize still more it with SIMD 
>> instructions in kernelspace and userland.
>
> He said SHA-1 is insignificant.

Actually davem also said it *is* significant on SPARC. But of course
J. C. Pizarro's suggested solution won't work because you can't just go
around replacing SHA-1 in git with something else :) you could *add* new
hashing methods, but you couldn't avoid SHA-1, and adding a new hashing
method would bloat every object and every hash in objects like commits
with an indication of which hashing method was in use.

(But you know this.)

>> 1.   "Don't compress this repo but compact this uncompressed repo
>>       using minimal spanning forest and deltas"

... and then you do a git-gc. Oops, now what?

... or perhaps you want to look something up in the pack. Now you have to
unpack a large hunk of the whole damn thing.

>> 2.   "After, compress this whole repo with LZMA (e.g. 48MiB) from 7zip before
>>       burning it to DVD for backup reasons or before replicating it to
>>	internet".
>
> Patches? ;-)

Replicating a pack to the internet is almost invariably replicating
*parts* of a pack anyway, which reduces to the problem with option 1
above...

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET
