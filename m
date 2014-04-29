From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v5 1/6] pull: rename pull.rename to pull.mode
Date: Wed, 30 Apr 2014 00:00:03 +0100
Organization: OPDS
Message-ID: <7B859CB604CE45AEA1DE2C9A9EF6C2B9@PhilipOakley>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com> <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com> <5324ACC54F034438BBAFDB15A9D716D5@PhilipOakley> <53602210aff0c_10a211e3308d@nysa.notmuch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"John Keeping" <john@keeping.me.uk>, "Jeff King" <peff@peff.net>,
	"Richard Hansen" <rhansen@bbn.com>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfH0U-0001IJ-3t
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 01:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbaD2XAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 19:00:04 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:15978 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbaD2XAC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 19:00:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqYXAJQtYFNZ8YTM/2dsb2JhbABNDIMGhAuFPbx2BQECAQGBIxd0giAFAQEEAQgBARMGFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYgcAwkMpiyFWZcSDYZbF4Epiw+BMAFmgnY1gRUEj2uFM4ICjn2FVYMyPA
X-IPAS-Result: AqYXAJQtYFNZ8YTM/2dsb2JhbABNDIMGhAuFPbx2BQECAQGBIxd0giAFAQEEAQgBARMGFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYgcAwkMpiyFWZcSDYZbF4Epiw+BMAFmgnY1gRUEj2uFM4ICjn2FVYMyPA
X-IronPort-AV: E=Sophos;i="4.97,953,1389744000"; 
   d="scan'208";a="465008983"
Received: from host-89-241-132-204.as13285.net (HELO PhilipOakley) ([89.241.132.204])
  by out1.ip01ir2.opaltelecom.net with SMTP; 29 Apr 2014 23:59:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247662>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Philip Oakley wrote:
>> From: "Felipe Contreras" <felipe.contreras@gmail.com>
>> > Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.
>>
>> Sorry I haven't commented earlier. Because the 0/6 explanation isn't 
>> a
>> commit, a few extra words would be useful to capture what the 0/6 
>> cover
>> letter said to start the patch series cleanly/clearly e.g. start with
>>
>>     Begin the "Reject non-ff pulls by default" process by creating 
>> new
>>     config variables which will allow extra options, to replace the 
>> old
>> pull
>>     configuration options.
>>
>> I didn't immediately grasp why the 'replacement' was happening, 
>> rather
>> than it being a creation and a deprecation.
>
> How about this:
>
>> > This way 'pull.mode' can be set to 'merge', and the default can be
>> > something else.

My initial problem was the word sequence order which, in the original, 
started with the 'replace' statement, which tripped me up. So I was 
looking for some preparatory wording to set the scene and avoid the 
trip.
(I'm assuming you were noting that you already had the subsequent "This 
way 'pull.mode'.." statement, unfortunately I'd already tripped up by 
then in the original, hence the suggestions for the scene setting)

>
> This will allow us to eventually add a 'merge-ff-only' option, and
> eventually set it as default to solve the problem of not rejecting
> non-ff pulls by default.
>
>> > The old configurations still work, but get deprecated.
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
>> > --- a/Documentation/config.txt
>> > +++ b/Documentation/config.txt
>
>> > @@ -764,15 +764,15 @@ branch.<name>.mergeoptions::
>> >  option values containing whitespace characters are currently not
>> >  supported.
>> >
>> > -branch.<name>.rebase::
>> > - When true, rebase the branch <name> on top of the fetched branch,
>> > - instead of merging the default branch from the default remote 
>> > when
>> > - "git pull" is run. See "pull.rebase" for doing this in a non
>> > - branch-specific manner.
>> > +branch.<name>.pullmode::
>> > + When "git pull" is run, this determines if it would either merge 
>> > or
>> > + rebase the fetched branch. The possible values are 'merge',
>> > + 'rebase', and 'rebase-preserve'. See "pull.mode" for doing this 
>> > in a
>> > + non branch-specific manner.
>>
>> I'd think it useful to add that:
>>     branch.<name>.rebase is deprecated.
>> given the large amount of internet cruft about this older config
>> variable name
>
> I don't recall deprecated configurations in the documentation, but I
> don't see a problem adding that either.

I'm sure that Junio will be able to form an opinion, which could go 
either way. On the one hand we try to avoid endless deprecation notices 
that then never get removed. On the other, we have the internet advice 
to set those old variables, so its worth associating them with their 
newer replacement with the warning. It'll be some else's judgment call 
at the end of the day.

>
> -- 
> Felipe Contreras
>
--
Philip 
