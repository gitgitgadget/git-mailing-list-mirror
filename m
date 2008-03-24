From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 11:45:59 -0500
Message-ID: <47E7DAC7.9020607@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <47E7D818.7090501@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 17:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdppG-0004iN-UO
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbYCXQqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbYCXQqU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:46:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41969 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbYCXQqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:46:19 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OGk2nq027479;
	Mon, 24 Mar 2008 11:46:02 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 11:45:59 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47E7D818.7090501@nrlssc.navy.mil>
X-OriginalArrivalTime: 24 Mar 2008 16:45:59.0852 (UTC) FILETIME=[8A067EC0:01C88DCE]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes-0.043500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtODMzNTE4LTcwMzczMS03MDE0NTUtNzA3NDUxLTcwOTE4NS03?=
	=?us-ascii?B?MDA3NjUtNzAwNjMwLTcwNjExNC03MDEyMjAtNzAwODA3LTcwMzc4?=
	=?us-ascii?B?OC03MDA3NTYtNzA0OTgwLTcwMjA1Ny03MDIwMzctNzAxOTI0LTcw?=
	=?us-ascii?B?MjAyMC03MDQ5MjctNzEwODQyLTE0ODAzOS0xNDgwNTEtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78060>

Brandon Casey wrote:
> Johannes Schindelin wrote:
>> Hi,
>>
>> On Mon, 24 Mar 2008, Junio C Hamano wrote:
>>
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> On Sun, 23 Mar 2008, Junio C Hamano wrote:
>>>>
>>>>> If you tell filter-branch to filter a branch A and a tag T, as the 
>>>>> command is advertised to rewrite positive refs that were given from 
>>>>> the command line, isn't it natural to expect that the command would 
>>>>> attempt its best effort to rewrite such a tag object?
>>>> The thing is: signed tags cannot be rewritten.
>>> I know that, and you know I know that if you read what you responded 
>>> again ;-)
>>>
>>> And I think stripping of gpg signature part is a reasonable best effort 
>>> for the command, _when_ the user told a signed tag to be rewritten.
>> Yes.
>>
>> BUT.
>>
>> You can say "--all", and I actually expect quite a few people to do 
>> exactly that.  And then you cannot really say "the user explicitely asked 
>> to have that signed tag rewritten".
> 
> That sounds like saying that specifying "HEAD" as the revision (_and_
> using --tag-name-filter) is not explicitly asking for tags to be rewritten.

Maybe that should be qualified. I think your statement is similar to my
example and so "not explicitly asking for tags" (by your definition) since
neither explicitly named the tags to be rewritten on the command line.

In both cases, tag objects would currently be replaced by lightweight tags
when --tag-name-filter is used.

-brandon
