From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 21:53:56 +0100
Organization: OPDS
Message-ID: <2B281B554A864399824A4BCD613A819D@PhilipOakley>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com><1368689474-28911-2-git-send-email-felipe.contreras@gmail.com><7v61yi9arl.fsf@alter.siamese.dyndns.org><CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com><7v8v3e7udi.fsf@alter.siamese.dyndns.org><CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com><7vk3my6bu1.fsf@alter.siamese.dyndns.org><CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com><7vk3my33vb.fsf@alter.siamese.dyndns.org><CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com><7vtxm1xxvd.fsf@alter.siamese.dyndns.org><E74470E4201142788D36127322130401@PhilipOakley> <CAMP44s3oNyCzH=ySNuB0f6yn536S=pUKDETAhBOwk_siFn30EQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 22:53:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udo8C-0002rz-Kb
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 22:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab3ERUx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 16:53:28 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52099 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198Ab3ERUx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 May 2013 16:53:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AncOAE/pl1FZ8YNG/2dsb2JhbABbgwiDa4U/uEsEAQMBexd0ghoFAQEFCAEBGRUeAQEhCwIDBQIBAxEEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwGHagMTrAGIGw2IboEmiySBbWqCSDJhA45ohmqOA4UjgxA7
X-IronPort-AV: E=Sophos;i="4.87,700,1363132800"; 
   d="scan'208";a="429289278"
Received: from host-89-241-131-70.as13285.net (HELO PhilipOakley) ([89.241.131.70])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 May 2013 21:53:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224807>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Saturday, May 18, 2013 3:23 PM
> On Sat, May 18, 2013 at 8:12 AM, Philip Oakley <philipoakley@iee.org>
> wrote:
>> From: "Junio C Hamano" <gitster@pobox.com>
>> Sent: Friday, May 17, 2013 7:30 PM
>> Subject: Re: [PATCH 1/3] fetch: add --allow-local option
>>
>> [...]
>>
>>
>>> So when "the user" is running "git fetch" on "mywork" branch that
>>> happens to be forked from a local "master", i.e. her configuration
>>> is set as
>>>
>>> [branch "mywork"]
>>>        remote = .
>>>                merge = refs/heads/master
>>>
>>
>> Was the '.' example illustrative rather than exact. I see no case of
>> using
>> '.' in my configs. Or am I completely missing the point? (e.g. that
>> the use
>> of '.' an example of possible future usage)?
>
> % git checkout -t -b feature master
> # work
> % git rebase -i
>
> -- 
> Felipe Contreras
> --

OK, I see it (the dot '.' in the config file) now.

I've also located the documentation hidden at the end of git-config(1)
under branch.<name>.merge, even though your worked example has it
under remote not merge.
    [branch "feature"]
     remote = .
     merge = refs/heads/master

"If you wish to setup git pull so that it merges into <name> from
another branch in the local repository, you can point
branch.<name>.merge to the desired branch, and use the special setting .
(a period) for branch.<name>.remote."

It feels as if this dwimmery(?) should also be listed in the gitcli(7)
documenation and under branch.<name>.remote in git-config(1) above it.

The use of dot '.' occured in a reply a couple of weeks ago:

Sent: Saturday, May 04, 2013 7:51 PM
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked 
out?
"Jonathan Nieder" <jrnieder@gmail.com> wrote:
> Another trick is to use "git push":
>         git push . $production_sha1:refs/heads/master


Philip
