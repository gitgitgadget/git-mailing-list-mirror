From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Tue, 13 Oct 2015 20:24:51 +0100
Organization: OPDS
Message-ID: <B846BC4FDE6944D39DC79E245264E544@PhilipOakley>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr> <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com> <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Konstantin Khomoutov" <kostix+git@007spb.ru>,
	"Francois-Xavier Le Bail" <devel.fx.lebail@orange.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Mike Rappazzo" <rappazzo@gmail.com>,
	"Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 21:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm5C4-00030h-79
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbJMTYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 15:24:54 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:54354 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752AbbJMTYx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 15:24:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DNPADeWR1WPFc7FlxeGQECAYMJgUKGW224M4MTgn8EBAKBS00BAQEBAQEHAQEBAUABJBtBAQEDAYNaBQEBAQEDCAEBGQQRHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgIAxavC4ZYh2MNhSiBIoVThH6CUIFlWIJwMYEUBZYWAYEeigeDTJFof4Nag2+CdB2BVT0zggBogiIfgUgBAQE
X-IPAS-Result: A2DNPADeWR1WPFc7FlxeGQECAYMJgUKGW224M4MTgn8EBAKBS00BAQEBAQEHAQEBAUABJBtBAQEDAYNaBQEBAQEDCAEBGQQRHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgIAxavC4ZYh2MNhSiBIoVThH6CUIFlWIJwMYEUBZYWAYEeigeDTJFof4Nag2+CdB2BVT0zggBogiIfgUgBAQE
X-IronPort-AV: E=Sophos;i="5.17,679,1437433200"; 
   d="scan'208";a="611974631"
Received: from host-92-22-59-87.as13285.net (HELO PhilipOakley) ([92.22.59.87])
  by out1.ip04ir2.opaltelecom.net with SMTP; 13 Oct 2015 20:24:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279517>

From: "Mike Rappazzo" <rappazzo@gmail.com>
> On Tue, Oct 13, 2015 at 1:07 PM, Jacob Keller <jacob.keller@gmail.com> 
> wrote:
>> On Tue, Oct 13, 2015 at 6:29 AM, Philip Oakley <philipoakley@iee.org> 
>> wrote:
>>> My tuppence is that the only sha1's that could/would be rewritten would 
>>> be
>>> those for the commits within the rebase. During rebasing it is expected 
>>> that
>>> the user is re-adjusting things for later upstream consumption, with 
>>> social
>>> controls and understandings with colleagues.
>>>
>>
>> Agreed here. There would be no need to change any sha1s that didn't
>> change during the rebase. This limits the scope. Alright.
>>
>>> Thus the only sha1 numbers that could be used are those that are within 
>>> the
>>> (possibly implied) instruction sheet (which will list the current sha1s 
>>> that
>>> will be converted by rebase to new sha1's).
>>>
>>
>> Correct, you would be able to limit the number of sha1s to search for.
>>
>> However, (see below), any reasonable reference to a sha1 should be
>> relatively stable.
>>
>>> It should be clear that the sha1's are always backward references 
>>> (because
>>> of the impossibility of including a forward reference to an as yet
>>> un-created future commit's sha1).
>>>
>>> The key question (for me) is whether short sha1s are accepted, or if 
>>> they
>>> must be full 40 char sha1's (perhaps an option). There are already 
>>> options
>>> for making sure that short refs are not ambiguous.
>>>
>>> It sound to me like a sensible small project for those that have such a
>>> workflow. I'm not sure if it should work with a patch based flow when
>>> submitting upstream - I'm a little fuzzy on how would the upstream
>>> maintainer know which sha1 referred to which patch.
>>>
>>
>> My issue: the only sha1s in commit messages are *generally* things
>> which will NOT be changed in general. Supporting a work flow that
>> wants to change these is definitely crazy.
>>
>> Essentially: I don't see a reason that you would be rebasing a commit
>> and needing to change any references in it. You can reference a commit
>> which isn't changing, but here's the possible situations I see:
>>
>> a) you are rebasing a commit which references in the message a commit
>> that is not being changed (it is ancient)
>>
>> In this case, nothing needs to be done.
>>
>> b) you are rebasing a commit which references another commit in the same 
>> rebase
>>
>> I see no valid reason to reference a sha1 in this case. If you're
>> referencing as a "fixes", then you are being silly since you can just
>> squash the fix into the original commit and thus prevent introduction
>> of bug at all.
>>
>> What other reason? If you are referencing such as "thix extends
>> implementation from sha1" then your commit message is probably poorly
>> formatted. I don't see a reason to support this flow.
>>
>> c) you are rebasing a commit which is referencing a commit that has
>> already been changed. (?)
>>
>> I think (maybe) this is your interesting case, but here are some caveats.
>>
>> Let's say you are fixing some old commit such as "Fixes: <sha1,
>> summary, date>" or something.
>>
>> If you do a "git pull --rebase", your commit might be updated to play
>> ontop of more new work, but the sha1 should still be valid, *unless*
>> the remote history did some rewind, at which point I don't think any
>> algorithm will work, see the issues above.
>>
>> It may be something worth doing in git-filter-branch, but then you're
>> looking at losing the two assumptions above making it really hard to
>> get right.
>>
>> Regards,
>> Jake
>
> It seems reasonable that this could be added as a feature of
> interactive rebase.  The todo list could be automatically adjusted to
> "reword" for those commits which are referring to other commits within
> the same rebase.  As each commit is re-written, a mapping could be
> kept of old sha1 -> new sha1.  Then when one of the reworded commits
> is being applied, the old sha1 -> new sha1 mapping could be used to
> add a line to the $COMMIT_MSG.
> --
The extra fun begins if the commit message is of a one-line pretty quoted 
style, where more of the quote needs changing...
e.g.
[alias]
 quote = log -1 --pretty='tformat:%h (%s, %ad)' --date=short
 log1 = log -1 --pretty=\"format:%ad %h (%an): %s\" --date=short

Jake was concerned about the 'crazy' workflow, however almost all workflows 
are crazy at a distance.
The rebase is required if the workflow's allowed base point moves forward 
faster than one can complete the (likely long) patch series, so the series 
is rebased and then an acceptable series can be merged without 
modifications.
Git has the former issue i.e. master and next can move forward faster than a 
long series takes to be reviewed, but does not have the latter because Junio 
adds his signature to each commit, and uses the patch submission flow.

IIUC (as an alternate example),  in G4W one can submit a (long) pull request 
with internal back references that would be merged directly, so the sha1's 
could be updated as Francois-Xavier originally asked. I have a series that's 
been bumping along for a long while that needs regular rebasing, though 
doesn't have sha1 back references, so I can see that the need does happen. I 
can see that others may have a workflow that would work well with the sha1 
auto-update.

--
Philip
