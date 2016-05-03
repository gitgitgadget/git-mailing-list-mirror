From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Tue, 3 May 2016 18:02:07 +0200
Message-ID: <55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461942126-16296-1-git-send-email-tboegi@web.de>
 <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
 <a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
 <xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
 <xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 18:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcmQ-0002a2-4V
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933816AbcECQC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:02:29 -0400
Received: from mout.web.de ([212.227.15.3]:63672 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933811AbcECQC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:02:26 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LdVdS-1bOT150z2o-00igyp; Tue, 03 May 2016 18:02:13
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:G+eLSII6GwE9lbCQwUDTI8BfN68nrA6AerTownQRCt1vzvOXShH
 16UQnl2M9lUON9Fr6AH5dU6T3Q/GFjCRR8bYI6Ix/tLR5AXJFQB0a+xOhFrM18VEWbXQgaM
 kcXEoKzU30nEDS6nbr50mYfnGmPcFgToja6BhZxfFbjNQ7mK37CekzTG9Ao1POZFKYoVbHx
 Rp+QBb1HxBlrxIa33Sn/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zbua/qBjKIg=:dN7J8yRkG6ltQ6EUR3LVM7
 6nBBXJVuEphnSl+rPPGd/+LSsVQLszxcAeEUch68EOArjkDnY59Qy114+gytSdp4SuP64o3vO
 6amB/ExKFAowx26ILLh3EKyXQeaKBx+JdrN6ZY6ahAjaQxRrrgD+HOqVeGiOiJC7ks9xXDrts
 G/L7sKLqNgUYrJPJBpKji6bRUWmEuBYGa1f3H0oRz/Q17iHC9CmdAOhmWLSDIV/3U1syVPlxw
 J7tp4oqlfq2/YI9KlenOD28jIhHTga+I63kjeKIaLrVL8EzFzw3rv0hkihmOKA2eDGCZvx8ft
 7dGhxMTCIMDvw6t4sf0tz6WMROaHwJI6rJUPjlSH6zbsnCeTms9JWawQnwa2GjffbSyXJFBsB
 fw6Y6hPwBZS1AjPGT2fpObHLty9SRS0dUwvp6ZdxBrlxwiGW4ty2S/yKP9SBi/5pq1urd1i2l
 q/7WCl4AxFV1GuuaJmUgQzgej/g21IreXd1F+AcxRsc3lJPC6zL6IRNHDBb2p6NYxIa40MLNr
 9sS/n+6ItpP874ueYSL+yUNi5nmxYn0H19wM8u3Rkq2+97dSr1jRAoU4t648QW/PsqF7FzK6y
 30ta7ltym0mcpJiFg4KVzOpu+VaIbQTOY0zw7aR8f/6H7FenVDAVmClczLV+6Ff+k7Q5eL8uT
 E+nI9gWJ42As9RLzQNS2g/E88My17qcT3+hTJ13KQW4pbXlgIHEUREIOvfg1mSdN1H6Y5garf
 CNuCkXQ4G3qj5lsbPJsA8bHhU/HkP6UKJalXivlAW4TrbvszY5II8lh+SI0tI4CHcaLFUJGL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293406>

On 2016-05-02 21.33, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> Let's step back a bit and make sure we are on the same page.  I
> think this "series" conflates a bit too many things into a single
> topic.
> 
>  * The comparison between the index and the working tree, i.e. "git
>    diff", should compare result of convert_to_git() with what is in
>    the index, and the world around it should be made consistent with
>    that.  Your separate "git blame" fix to add missing knowledge
>    that convert_to_git() would not do s/CRLF/LF/ for a path whose
>    index entry already is contaminated with CR falls into this
>    category and was a very good thing to do.  
> 
>  * A convert_to_git() and convert_to_working_tree() pair that do not
>    roundtrip would (by definition) leave contents in the working
>    tree, that, when passed through convert_to_git(), will be
>    different from the index, upon completion of "reset --hard".  We
>    _should_ fix it so that "git diff" _reports_ differences.
>    Currently, lstat(2) based optimization hides this in a racy way
>    (when racy Git kicks in to reinspect the index and the working
>    tree file actually matches, it finds out that they do not match),
>    it is a bug that needs to be fixed, not 10/10 where it tries to
>    hide the differences consistently and spreads the bug.  I haven't
>    studied 8/10 carefully yet, but it seems to attempt the same.
> 
>  * I think the "text=auto eol=THIS" that did not mean "I do not care
>    to specify which ones are text files.  Please detect the file
>    type, and for those automatically detected, please make sure that
>    the contents follwo THIS eol convention." was a bug, and what
>    07/10 tries to do is a good thing.  
> 
> By the way, lack of the cover letter of this series made it more
> painful to write a reply like this than necessary.  A cover letter
> for a trivial 3-patch series might be overkill, but for anything
> with substance that spans more than 4-5 patches, a cover letter to
> describe the overall direction would really help.


The 10/10 needs to be replaced with something different, and I start to
get a better picture, why.
read_cache.c/ce_compare_data() checks what "git add" will change in the index.

sha1_file.c/index_fd() will read the file content from the working tree,
run convert_to_git() and calculate the sha1, which read_cache.c feeds into
hashcmp().

When convert_to_git() is run, 3 steps are taken:
- apply the filter, if any
- run crlf_to_git(), if attributes and core.autocrlf say so
- run ident, if specified.

Now the crlf_to_git() uses has_cr_in_index(const char *path) to find
out if we should keep the CRLF or not.

Side note: the suggested patches will use
get_convert_stats_sha1(get_sha1_from_cache(path),)

This works pretty well under normal "git add", but fails in t6038,
when we do a merge.

The new function get_sha1_from_index() can not find the sha1,
"read-cache.c/get_sha1_from_index:2392 path=file pos=-3"
and falls into the code path for
		/*
		 * We might be in the middle of a merge, in which
		 * case we would read stage #2 (ours).
		 */
read-cache.c/get_sha1_from_index:2408 path=file pos=3
read-cache.c/get_sha1_from_index:2416 path=file sha1=ad55e2

(The line number are with debug code)

The problem is, that ad55e2 is _not_ the sha1, which
read_cache/ce_compare_data() had been asked to look at.
Instead we should check the blob with 99b633.

The result is that convert/get_convert_stats_sha1() is called on the
wrong blob (the one with CRLF instead the one without CRLF), and this
makes t6038 from 9/10 fail.
10/10 rescues the situation, by using the correct blob :-)

In short, ce_compare_data() needs to forward ce->sha1 the whole way into
convert.c/crlf_to_git() and get_convert_stats_sha1().

While at it, I realized that we call a convert_attrs(&ca, path) a couple
of times (e.g. in would_convert_to_git(), to find out that we really don't have
any attributes set.

It could be nice to do that only once.

The next step will be to add the improvements/fixes for the ce_compare_data()
chain as described above, and then put 7/10..9/10 on top of that.
This will probably take some time, so that's why I asked if 1/10..4/10 could
proceed as is ?
(and the next version with cover letter, sorry for that)
