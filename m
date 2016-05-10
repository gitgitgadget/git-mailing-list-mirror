From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v9 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 10 May 2016 13:12:28 +0200
Message-ID: <20160510131228.Horde.WHWUaWE4DeqFLnoMEbjxcxG@webmail.informatik.kit.edu>
References: <1462826929-7567-4-git-send-email-dturner@twopensource.com>
 <20160510101315.32403-1-szeder@ira.uka.de>
 <CACsJy8DLmcxmw5aGT3FszccW3UNujBcr8uZzJuJoWxvASKnpPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b05aj-0007KM-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcEJLMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 07:12:37 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39042 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133AbcEJLMh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:12:37 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b05ac-0006bq-6O; Tue, 10 May 2016 13:12:34 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b05aW-0007CP-GO; Tue, 10 May 2016 13:12:28 +0200
Received: from x4db0dd69.dyn.telefonica.de (x4db0dd69.dyn.telefonica.de
 [77.176.221.105]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 10 May 2016 13:12:28 +0200
In-Reply-To: <CACsJy8DLmcxmw5aGT3FszccW3UNujBcr8uZzJuJoWxvASKnpPg@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462878754.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294118>


Quoting Duy Nguyen <pclouds@gmail.com>:

> This reminds me, we need to update command-list.txt as well. I guess
> it belongs to purehelpers? Back to the patch..
>
> On Tue, May 10, 2016 at 5:13 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> This patch adds a new plumbing command, which then will show up in
>> completion after 'git <TAB>'.  Could you please squash in this
>> oneliner to exclude index-helper from porcelain commands in the
>> completion script?
>
> I don't think the user should run this command explicitly a lot.
> Usually it should be run automatically (with config key
> indexhelper.autorun) and die when idle for some time. You just don't
> care about it (until performance degrades and you have to
> investigate). Occasionally you may have to "git index-helper --kill".
> Is there any other reason it should be run often enough to justify
> this change?

I think you misunderstood this change, it _excludes_
'index-helper' from the list of porcelain commands.

>> ---
>>  contrib/completion/git-completion.bash | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/contrib/completion/git-completion.bash =20
>> b/contrib/completion/git-completion.bash
>> index 34024754d929..9264ab919a6a 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -684,6 +684,7 @@ __git_list_porcelain_commands ()
>>                 for-each-ref)     : plumbing;;
>>                 hash-object)      : plumbing;;
>>                 http-*)           : transport;;
>> +               index-helper)     : plumbing;;
>>                 index-pack)       : plumbing;;
>>                 init-db)          : deprecated;;
>>                 local-fetch)      : plumbing;;
>> --
>> 2.8.2.356.ge684b1d
>>
> --
> Duy
