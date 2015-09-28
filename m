From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 28 Sep 2015 21:58:08 +0200
Organization: gmx
Message-ID: <da381393c0b6174cc07b4333308cf611@dscho.org>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
 <fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
 <xmqqpp12croq.fsf@gitster.mtv.corp.google.com>
 <xmqqh9mecrap.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 21:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgeZA-0007a7-LS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 21:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbbI1T6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 15:58:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:49328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbbI1T6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 15:58:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYx2x-1aBoCf0BU3-00Vkqp; Mon, 28 Sep 2015 21:58:10
 +0200
In-Reply-To: <xmqqh9mecrap.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:+6jeRWJRj7h44afm6MPrJaU0W54rtG9bcb16EEt4FfWkhDfidYf
 pT+Y3csgC/CukgGnVgKs7gml2OPEiQYo4orbeVBV5wp34/vL2vKyFL724+rUKPHy7rFanWt
 QDOCsuTRbycEC6pArbuhKjqS7RyyFdLNqvuDE3UPE4R82rjE952Ol+JxG1Me+SJUQIyvUla
 OmjiSBAIlzLK+DhgRPjNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pzn8sTFAR7E=:neUDdH6MWLLOjllTzRcfVV
 fcRV/RETWU8JxWkpRm349Vrlf2uBhnWb9jUXIAPjmHCuOpB+zB6w4InTcqUAPYMU/lxcxjgLF
 CVUZk8rXMZex6dI5BJ8KdJ4Tu7Wpm7gf7T32Xy+OCKJkqOGZMbfs/mtZl6V9BvhoRZhkkbcFE
 fJj8HR4jrzaipj8WW7AgyQ2RLy3CsbU9aYrRmqja9O9J6A/y5EhNTBMjN2S48yH19Czb3kNQo
 umKrVO2HoJEULzQ8AenIOJtaMVV0Y8oWtg+vBMSZDwb4ogylnb+dtw0PNRiYLZ+WjLEUBQ9C3
 4UYp49GWYx0HWKl+KC54ROdxhQ+tXJNO9PCcMtgXdvm2oejeFmaHWt0o4XOruxim5YdaS5/aK
 c7bZw8JiRcwlUtD+3+/rer/UiiYbIjSoMXk8L4ExxkKK9a9Cq6QAOlbqWSKL8Z2EmMnfgZNEj
 sLtyBgn1youkuXOSevETb8Odb1dglaPU6DI/Th1+n7VFFyuGBCKPLZXYJAZZBmrdNo7jthW08
 Dw1HCNT+O65nfRagOxzh5B3So0a4q3k5xszQ2yN5vylQhm/5886yEuewHe8mbPQQ91PgPO3bj
 G+054uR0zNypdxlv2Jl+RbbUfasOpKh/YKp5PKjBY6YyYXEWdfZ0jdYECz/ebmCFEemg5oPVD
 7U8ubh+oY5fMri4mUUz3BtdvzAMpPoDU9RUiLpfIFR4Jm8xIABji4d4bzdq/bHKOKfnfsGaRO
 rhAK8XDPfxssJSw181Xx5Jj4iBwuwpzACgHXVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278748>

Hi Junio,

On 2015-09-28 20:49, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> When encountering broken symrefs, such as a stale remote HEAD (which can
>>> happen if the active branch was renamed in the remote), it is more
>>> helpful to remove those symrefs than to exit with an error.
>>
>> I think this depends on the perspective.  One side of me says that a
>> remote HEAD that points at refs/remotes/origin/topic that no longer
>> exists is still giving me a valuable information and it should take
>> a conscious action by the user to remove it, or evne better to
>> repoint it to a more useful place.  And from that point of view,
>> removing is not all that helpful.  Keeping them and not allowing
>> them to exit with an error would be a real improvement.
>>
>> On the other hand, I can certainly understand a view that considers
>> that such a dangling symbolic ref is merely a cruft like any other
>> cruft, and "gc" is all about removing cruft.
>>
>> It just feels to me that this is a bit more valuable than other
>> kinds of cruft, but maybe it is just me.
> 
> Sorry, it is a bad habit of me to send out without concluding
> remark, leaving the recipient hanging without knowing what the next
> step should be.
> 
> I meant to say that I plan to, and I indeed did, queue these 4
> without changes.  I am not opposed to the removal so strongly to
> reject [4/4].
> 
> The above comment was that I just do not know if this is the right
> thing to do, or it will be hurting users.

Oh, I appreciate your feedback. I am actually not all *that* certain that removing the broken symref is the correct thing. It is this sort of fruitful exchange that allows me to throw out an idea and be relatively certain that something better will come out of v3 or v8 of the patch series than what I had in mind.

To be honest, the most important outcome is probably 2/4 -- which should be enough to fix the issue reported by the Git for Windows user. I could adjust the test so that it no longer insists that `origin/HEAD` be deleted, but still requires that `git gc` succeeds.

I would have no problem to let this sit for a couple of days until the final verdict.

Ciao,
Dscho
