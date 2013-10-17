From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 22:14:26 +0100
Organization: OPDS
Message-ID: <5A09FF55D37146E7A02DF2F640A46406@PhilipOakley>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com><xmqqeh7k51vg.fsf@gitster.dls.corp.google.com><29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley><xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com><3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley> <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	"Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 23:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWutf-0004EW-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 23:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502Ab3JQVOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 17:14:16 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:63567 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932136Ab3JQVOO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 17:14:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnUMAHFSYFJOl3+a/2dsb2JhbABbgweJcbUaBAQCgSkXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghYjwG+OLoEjgyaBBwOJBIYSmnSBOiyBPzs
X-IPAS-Result: AnUMAHFSYFJOl3+a/2dsb2JhbABbgweJcbUaBAQCgSkXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghYjwG+OLoEjgyaBBwOJBIYSmnSBOiyBPzs
X-IronPort-AV: E=Sophos;i="4.93,517,1378854000"; 
   d="scan'208";a="434953823"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip05ir2.opaltelecom.net with SMTP; 17 Oct 2013 22:14:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236321>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> ... and the detection process for 'toplevel' may not work
>>>> properly when in a separated work-tree environment.
>>>
>>> Without GIT_WORK_TREE exported to point at the top-level, there is
>>> nothing that lets us "detect" it, as the working tree does not have
>>> ".git" directory to tell us to stop, no?
>>>
>>
>> "No", but not in that way.
>>
>> My point (to Dale) was, as you state, that the "cd to top level" was
>> (IIUC) the probable causes of the fault, and that a documentation
>> update would probably be appropriate for the discussion on exporting
>> GIT_WORK_TREE, and that it would specifically mention those git
>> commands that needed to "cd to top level", and hence would not work 
>> in
>> such an environment. (I wasn't sure where the appropriate "cd to top
>> level" function was)
>>
>> An explanation here on the list wouldn't solve the problems for 
>> others
>> who are yet to make the same mistake, hence the implied suggestion.
>
> I understand what you mean by these last two lines. It was unclear
> to me which part of our documentation needs updating and how, and
> that was (and still is) what I was primarily interested in finding
> out.
>
I was expecting that the places would be in git(1) [git.txt] and 
config(1) [config.txt], in the enironment variables GIT_WORK_TREE 
section and core.worktree sections repectively. However what the right 
text would be hasn't been fully determined yet, as it should be clear 
about which commands don't follow the stated 'rules'. Dale's use case 
does appear to be stretching...

Philip 
