X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 27 Oct 2006 12:49:58 +0200
Message-ID: <8fe92b430610270349k36a39250i7173282aa81c04e7@mail.gmail.com>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
	 <4541D291.5020205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 10:51:01 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NmVlDQ1G9IDF8XVwUJ/v75sV0FHefxKr4BQ51lom+fl7LyeP0HTBamPIqsgYitCUJsaXu+YldFXOG7nvH8pb1mfCrwMJ9nXxbtpkMjndOBksr7td9oyUMAGy9mOdVt4w6tDE603FuL0b8w0yIAMIxv0k1J/cWCoYAXSfS4Nz/KQ=
In-Reply-To: <4541D291.5020205@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30323>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdPIG-0006D8-HL for gcvg-git@gmane.org; Fri, 27 Oct
 2006 12:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946380AbWJ0KuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 06:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946382AbWJ0KuP
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 06:50:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46127 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946375AbWJ0KuA
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 06:50:00 -0400
Received: by ug-out-1314.google.com with SMTP id 32so641127ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 03:49:59 -0700 (PDT)
Received: by 10.78.134.12 with SMTP id h12mr4685820hud; Fri, 27 Oct 2006
 03:49:58 -0700 (PDT)
Received: by 10.78.115.2 with HTTP; Fri, 27 Oct 2006 03:49:58 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 10/27/06, Andreas Ericsson <ae@op5.se> wrote:
> Horst H. von Brand wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> [...]
>>
>>> I'd rather split "Supports Renames" into engine part (does SCM
>>> remember/detect that rename took place _as_ rename, not remember/detect
>>> it as copiying+deletion; something other than rename) and user interface
>>> part: can user easily deal with renames (this includes merging and
viewing file
>>> history).
>>
>> I think that what to tool does in its guts is completely irrelevant, what
>> is important is what the user sees. Sadly, it seems hard to describe
>> exactly what is meant/wanted here.
>
> Agreed. I'd rather make the definition "Can users, after a rename has
> taken place, follow the history of the file-contents across renames?".
> Mainly because this is clearly unambiguous, doesn't involve
> implementation details and only weighs what really counts: User-visible
> capabilities.

With this definition (with this part) it would be "Somewhat" for Git, because
user can track the history of file-contents across renames, but some additional
steps are required... until --follow=<pathname> would get implemented, that is.
Yet "tracking file-contents across renames" is based on specific workflow used;
for example with Git you usually track [some part of] history of some subpart
of a project, not history of single file. (I'd name it "History Rename Support"
or "Log Rename Support").

But equally important for user is another question related to
"Supporting Renames".
Namely detection of renames during merge and detection of conflict during merge
is what I would consider minimal "Merge Renames Support". Causing information
to be lost is having no "Merge Renames Support". To have "Yes" in this
column SCM
have to resolve conflict at least in obvious cases, and "Yes!" if it
can remember
resolution of merge conflict involving renames ;-).

> IMNSHO, I'd rather have all the features in the list be along the lines
> of "Can users/admins/random-boon do X?" and instead of "yes/no" list the
> number of commands/the amount of time required to achieve the desired
> effect. This would set a clear limit and put most terminology issues out
> of the way.

This would make the comparison table less clear, unfortunately.

>>> 13. Plugins. I would put "Somewhat" here, or "Scriptable" in the "Somewhat"
>>> or "?" background color for Git. And add note that it is easy to script up
>>> porcelanish command, and to add another merge strategy. There also was
>>> example plugin infrastructure for Cogito, so I'd opt for "Someahwt"
>>> marking.
>>
>> Mostly an implementation detail for "extensible"...
>>
>
> Yup. Any fast-growing SCM can clearly be said to be "extensible",
> otherwise it wouldn't be extended ;-)

I'd put "Easily Extensible" here, and put "Plugins (core+UI)" for Bazaar-NG,
and "Scriptable (UI+merge)" for Git, or something like that.

>> [...]
>>
>>> 19. Ease of Use. Hmmm... I don't know for Git. I personally find it very
>>> easy to use, but I have not much experiences with other SCM. I wonder why
>>> Bazaar has "No" there...
>>
>> Extremely subjective. Easy to learn doesn't cut it either.
>
> This one just needs to go. Could possibly be replaced with "Has
> tutorial/documentation online" or some such. No SCM is really intuitive
> to users that haven't experienced any of them before, so the only thing
> that really matters is how much documentation one can find online and
> how up-to-date it is.

For example SCM can be easy to use but at the cost of simplifications
and limited useness.

On the other side basic concept behind some SCM might be more
or less understandable...
-- 
