From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] builtin-tag.c: use valid_ident for checking tagger
 field
Date: Mon, 12 May 2008 10:51:55 -0500
Message-ID: <4828679B.6000507@nrlssc.navy.mil>
References: <1210309416-27787-1-git-send-email-author@example.com> <9526336.1210309346451.JavaMail.teamon@b304.teamon.com> <7vhcd43csh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvaKs-0000h3-3y
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYELPwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYELPwU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:52:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43847 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbYELPwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:52:20 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m4CFptvM014365;
	Mon, 12 May 2008 10:51:55 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 May 2008 10:51:55 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vhcd43csh.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 May 2008 15:51:55.0589 (UTC) FILETIME=[1A88FF50:01C8B448]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81877>

Junio C Hamano wrote:
> drafnel@gmail.com writes:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Use valid_ident function for validating the tagger field
>> in generated tags rather than a tag specific version.
>>
>> Also update tests.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>>  builtin-tag.c    |   39 +++++----------------------------------
>>  t/t3800-mktag.sh |   14 +++++++-------
>>  2 files changed, 12 insertions(+), 41 deletions(-)
>>
>> diff --git a/builtin-tag.c b/builtin-tag.c
>> index 0f79d47..2dcb795 100644
>> --- a/builtin-tag.c
>> +++ b/builtin-tag.c
>> @@ -339,8 +339,7 @@ static int verify_tag_buffer(const char *buffer, size_t size)
>>  	int typelen;
>>  	char type[20];
> 
> Funny.
> 
> This [2/2] seems to depend on [3/5] that renames verify_tag to verify_tag_buffer().
> 
> What is going on?

Yes, sorry. I should have mentioned this.

I implemented this after the other series, but it could just as well be merged into one,
with these two coming before the 5 patch mktag stuff. I can resubmit if you like.

-brandon
