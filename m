From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V2 2/3] config doc: update dot-repository notes
Date: Sat, 14 Sep 2013 21:47:40 +0100
Organization: OPDS
Message-ID: <001CC3ED329149C1B6BB9E3F271768C2@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1379107397-964-1-git-send-email-philipoakley@iee.org><1379107397-964-3-git-send-email-philipoakley@iee.org> <xmqq38p8icf3.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 22:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKwkq-0003bs-6C
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 22:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369Ab3INUrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 16:47:40 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:64378 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756730Ab3INUrk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Sep 2013 16:47:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArUGAKjKNFJOl3GZ/2dsb2JhbABagwc4iTq4DAqBHBd0giAFAQEEAQgBAS4WCAEBIQUGAgMFAgEDEQQBAQolFAEEGAIGBw8IBggLCAIBAgMBDASHXAoIuVmPcw2DGIEAA4kAhhKKGJBFgyU7
X-IPAS-Result: ArUGAKjKNFJOl3GZ/2dsb2JhbABagwc4iTq4DAqBHBd0giAFAQEEAQgBAS4WCAEBIQUGAgMFAgEDEQQBAQolFAEEGAIGBw8IBggLCAIBAgMBDASHXAoIuVmPcw2DGIEAA4kAhhKKGJBFgyU7
X-IronPort-AV: E=Sophos;i="4.90,904,1371078000"; 
   d="scan'208";a="431774616"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 14 Sep 2013 21:47:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234808>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, September 13, 2013 11:28 PM
Subject: Re: [PATCH V2 2/3] config doc: update dot-repository notes


> Philip Oakley <philipoakley@iee.org> writes:
>
>> branch.<name>.remote can be set to '.' (period) as the repository
>> path (URL) as part of the remote name dwimmery. Tell the reader.
>>
>> Such relative paths are not 'special'. Correct the 
>> branch.<name>.merge
>> note.
>
> Looks good.
>
> It naturally follows that this is also valid:
>
> [branch "master"]
>        merge = refs/heads/master
>         remote = git://git.kernel.org/pub/scm/git/git.git
>
> and running "git pull" while on your 'master'.
>
> This is because branch.<name>.remote usually is spelled with a
> nickname that refers to the [remote <nickname>] section, but it does
> not have to be; it can use a URL to refer to the remote repository.
>
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/config.txt | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 599ca52..da63043 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -718,6 +718,8 @@ branch.<name>.remote::
>>  overridden by `branch.<name>.pushremote`.  If no remote is
>>  configured, or if you are not on any branch, it defaults to
>>  `origin` for fetching and `remote.pushdefault` for pushing.
>> + Additionally, `.` (a period) is the current local repository
>> + (a dot-repository), see `branch.<name>.merge`'s final note below.
>>
>>  branch.<name>.pushremote::
>>  When on branch <name>, it overrides `branch.<name>.remote` for
>> @@ -743,8 +745,8 @@ branch.<name>.merge::
>>  Specify multiple values to get an octopus merge.
>>  If you wish to setup 'git pull' so that it merges into <name> from
>>  another branch in the local repository, you can point
>> - branch.<name>.merge to the desired branch, and use the special 
>> setting
>> - `.` (a period) for branch.<name>.remote.
>> + branch.<name>.merge to the desired branch, and use the relative 
>> path
>> + setting `.` (a period) for branch.<name>.remote.

This may need something extra because it doesn't say where it is 
relative to, nor comment on git_dir discovery (see patch 1 comments, 
likewise patch 3)

>>
>>  branch.<name>.mergeoptions::
>>  Sets default options for merging into branch <name>. The syntax and
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
