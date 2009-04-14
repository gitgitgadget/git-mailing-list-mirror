From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and
 spaces
Date: Tue, 14 Apr 2009 09:38:49 +0200
Message-ID: <49E43D89.50802@op5.se>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com> <1239647037-15381-3-git-send-email-mfwitten@gmail.com> <1239647037-15381-4-git-send-email-mfwitten@gmail.com> <1239647037-15381-5-git-send-email-mfwitten@gmail.com> <1239647037-15381-6-git-send-email-mfwitten@gmail.com> <1239647037-15381-7-git-send-email-mfwitten@gmail.com> <1239647037-15381-8-git-send-email-mfwitten@gmail.com> <1239647037-15381-9-git-send-email-mfwitten@gmail.com> <1239647037-15381-10-git-send-email-mfwitten@gmail.com> <7vab6ke0ip.fsf@gitster.siamese.dyndns.org> <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com> <49E41F99.6010409@op5.se> <27f7c25b-7bdc-40d1-a601-bd162ebbe2f2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 09:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtdFs-00006t-Aa
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 09:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZDNHiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 03:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZDNHiy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 03:38:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:18337 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZDNHix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 03:38:53 -0400
Received: by fg-out-1718.google.com with SMTP id e12so740585fga.17
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 00:38:51 -0700 (PDT)
Received: by 10.86.61.13 with SMTP id j13mr5307125fga.68.1239694731658;
        Tue, 14 Apr 2009 00:38:51 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm8587888fge.28.2009.04.14.00.38.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 00:38:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <27f7c25b-7bdc-40d1-a601-bd162ebbe2f2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116527>

Michael Witten wrote:
> On Tue, Apr 14, 2009 at 00:31, Andreas Ericsson <ae@op5.se> wrote:
>> Michael Witten wrote:
>>> On Mon, Apr 13, 2009 at 15:55, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Michael Witten <mfwitten@gmail.com> writes:
>>>>
>>>>> Currently, no lines match the following:
>>>>>
>>>>>    [\t]+[ ]+
>>>>>    [ ]+[\t]+
>>>> I understand the latter but what's wrong with the former?  The width of a
>>>> HT is by definition 8 columns throughout the git codebase.
>>> Ah, well, the width of a HT has been a free variable in my
>>> calculations; I was operating under the assumption that whitespace
>>> used for indentation can float freely according to the user's
>>> settings. A few of the lines were aligning function arguments via tabs
>>> and a few extra spaces, which is not reliable in my model.
>>>
>>> Frankly, I don't like tabs and spaces sharing the same contiguous
>>> block. I don't like it all. ;-B
>> Using tabs to align stuff to indentation level and spaces to align
>> line continuation is the only possible way to let users choose
>> whichever indentation depth they want while preserving the continuation
>> alignment. What's not to like about that? Especially if you think a
>> horizontal tab can be any size at all, you should be all agog.
> 
> However, nobody ever gets that right, because they don't understand
> what you mean by indentation level. For most code that people write,
> indentation whitespace overlaps with non-whitespace (from the
> previous line). Therefore, the spaces used for continuation alignment
> with the previous line are left 'sitting on shaky ground'. For
> instance, consider this fine piece of code, given by lines 609-612 in
> builtin-log.c. If you're viewing this code with a monospace font and
> HT set to 8 columns, then the tab->spaces expansion should give the
> following result (monospace font required to view this properly):
> 
> static void make_cover_letter(struct rev_info *rev, int use_stdout,
>                               int numbered, int numbered_files,
>                               struct commit *origin,
>                               int nr, struct commit **list, struct commit *head)
> 
> Beautiful, isn't it?
> 
> In this case, we're at indentation level ---> 0 <---, and this means
> that to form the continuation alignment, 0 tabs should be used
> followed by however many spaces are needed to achieve the alignment.
> However, whoever wrote that code actually used indentation level 3:
> 
> <HT><HT><HT><SP><SP><SP><SP><SP><SP>
> 

Well, that would have been true if git had used "indent with tabs align
with spaces" (allowing variable width HT's), but HT is defined as 8
spaces wide, so that's a non-issue for us.

> The problem is that variable-width characters (HTs) are being aligned
> with fixed-width characters. For shame!
> 
> To be explicit, if the HT width is set to 4, the result would be
> (after HT->spaces expansion):
> 
> static void make_cover_letter(struct rev_info *rev, int use_stdout,
>                   int numbered, int numbered_files,
>                   struct commit *origin,
>                   int nr, struct commit **list, struct commit *head)
> 
> Clearly, this is never a problem if you declare HTs to be fixed-width
> (which, I believe, Linus did do: 8 columns per HT), or if you can
> remember that HTs should never be used to align against non-HTs.
> 

There you have it then; It's not a problem for git.git, and yet you
propose to fix it.

> What I like to do is provide a more regular structure that removes the
> juxtaposition of indentation and alignment whitespace. Basically, HTs
> and spaces should never be contiguous, and the first use of a non-HT
> prohibits HTs from being used anywhere further down the line. Also,
> the structure of the code should facilitate identation levels:
> 
> static void make_cover_letter
> (
> 	/* These are all at indentation level 1 */
> 
> 	struct rev_info* rev            ,
> 	int              use_stdout     ,
> 	int              numbered       ,
> 	int              numbered_files ,
> 	struct commit*   origin         ,
> 	int              nr             ,
> 	struct commit**  list           ,
> 	struct commit*   head
> )
> {
> 	/* Code at indentation level 1 */
> }
> 
> Yeah, yeah, I know it's crazy, but it makes code wildly readable---to me.
> 

It would still fail with a variable-width font though, which you seem
keen on reminding people about.

Since you seem really, really keen on getting this done, here's the only
way Junio would possibly even consider your new indentation style for
git.git:
* Make patches for all the .c and .h files.
* Make patches to all topics sent to the list that haven't been merged
  or dropped yet so that merges can go on cleanly.
* Create a public git repository somewhere which Junio can fetch from,
  marking your topic-branches clearly.
* Come up with a better argument than "Hey, this is better for me".
  Since churning code just to make life a little bit easier for one guy
  responsible for 0.07% of the committed codebase would be damn silly,
  I'm reasonably certain Junio will just shake his head at your proposal.
  Without the patches though, he'll probably not even look at it. 


There's one pretty good reason *not* to change indentation though:
Ownership tracking in case of relicensing. Currently, the "owners"
of a file in git.git can be determined pretty accurately by issuing

  git blame -C -C -M "$f" | \
  sed -e 's/[^(]*(\([^0-9]*\).*/\1/' -e 's/[\t ]*$//' \
        | sort | uniq -c | sort -nr

which is immensely useful when asking permission to relicense code
for libgit2. With your proposed code churn, that goes out the window
for no benefit what so ever.

Happy hacking. I'll drop this subject now, hoping you do the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
