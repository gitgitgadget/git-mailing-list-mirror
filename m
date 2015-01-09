From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Fri, 9 Jan 2015 08:48:30 -0000
Organization: OPDS
Message-ID: <1ED88DC1DCC2463782B4F4167DC85D5D@PhilipOakley>
References: <1420496573-3260-1-git-send-email-philipoakley@iee.org> <xmqqbnmajwd9.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:54:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9VFB-0001kt-B2
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbbAIIs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2015 03:48:29 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:2188 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756034AbbAIIs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2015 03:48:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgOAJyUr1RZ8YLCPGdsb2JhbABcgwaBKoYvbMROBAKBGUQBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBASgBBR4BARwFCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIEwy6So0fASuPeYMdgRMFhDiEfoR/TolJikqCXoM5glSBPD4xgkMBAQE
X-IPAS-Result: AvgOAJyUr1RZ8YLCPGdsb2JhbABcgwaBKoYvbMROBAKBGUQBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBASgBBR4BARwFCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIEwy6So0fASuPeYMdgRMFhDiEfoR/TolJikqCXoM5glSBPD4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.07,729,1413241200"; 
   d="scan'208";a="580411989"
Received: from host-89-241-130-194.as13285.net (HELO PhilipOakley) ([89.241.130.194])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 09 Jan 2015 08:48:26 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262236>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The assume-unchanged bit, and consequently core.ignoreStat, can be
>> misunderstood. Be assertive about the expectation that file changes=20
>> should
>> notified to Git.
>>
>> Overhaul the general wording thus:
>>     1. direct description of what is ignored given first.
>>     2. example instruction of the user manual action required.
>>     3. use sideways indirection for assume-unchanged and update-inde=
x
>>        references.
>>     4. add a 'normally' to give leeway for the change detection.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> This is the corrected patch which now applies on top of next and has=
=20
>> been
>> checked on AsciiDoc. (was $gmane/261974/focus=3D262022)
>>
>> I have included the previous 'after three-dashes' comment and=20
>> included
>> them in the commit message. I'm happy for it to be tweaked as=20
>> appropriate.
>
> Thanks.
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 52eeadd..fe179d0 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -375,15 +375,18 @@ This is useful for excluding servers inside a=20
>> firewall from
>>  proxy use, while defaulting to a common proxy for external domains.
>>
>>  core.ignoreStat::
>> + If true, Git will avoid using lstat() calls to detect if files hav=
e
>> + changed. Git will set the "assume-unchanged" bit for those tracked=
=20
>> files
>> + which it has updated identically in both the index and working=20
>> tree.
>
> I wonder if this is better stated in two seemingly independent
> sentences (like your version), or "... if files have changed by
> setting the assume-unchanged bit ...." to clarify where the setting
> of the bits to these files come into the big picture, but it is
> minor.  Either way, I think it is a lot easier to understand than
> what we have in 'master'.

I had considered a number of different wordings, and wanted to keep the=
=20
tricky parts separate to ease cognition.

On a separte note, this patch was a development from the problem notice=
d=20
by S=E9rgio of the different actions of 'git commit .'and 'git commit -=
a'=20
when --assume-unchanged was used. Did you have any thoughts regarding=20
Duy's patch (05 December 2014 10:56) to his code given in $gmane/260865=
=2E

I wasn't sure if it had just been missed, or if there was some other=20
issue?


>> ++
>> +When files are modified outside of Git, the user will need to stage
>> +the modified files explicitly (e.g. see 'Examples' section in
>> +linkgit:git-update-index[1]).
>> +Git will not normally detect changes to those files.
>> ++
>> +This is useful on systems where lstat() calls are very slow, such a=
s
>> +CIFS/Microsoft Windows.
>> +False by default.
>
> I think you are trying to make the result more readable by using
> separate paragraphs for separate conceptual points, but then isn't
> it wrong to have "False by default" as part of stating which
> platforms are intended targets?  I wonder if we want to have that
> last line as its own paragraph instead.

I was happy with it being a simple separate sentence.

>
> Thanks.
>
>>
>>  core.preferSymlinkRefs::
>>  Instead of the default "symref" format for HEAD
> --
Philip=20
