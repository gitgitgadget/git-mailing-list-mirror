From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Thu, 20 Mar 2008 12:38:23 -0500
Message-ID: <47E2A10F.1010703@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcOjf-00086D-50
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbYCTRio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbYCTRio
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:38:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34460 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbYCTRin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:38:43 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2KHcORu016349;
	Thu, 20 Mar 2008 12:38:24 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Mar 2008 12:38:23 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0803201812560.4124@racer.site>
X-OriginalArrivalTime: 20 Mar 2008 17:38:23.0709 (UTC) FILETIME=[324200D0:01C88AB1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15792001
X-TM-AS-Result: : Yes--10.243700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzA0NDIxLTcwNDQyNS03MTE2MTItNzAwNDc2LTcwMzk2OS03?=
	=?us-ascii?B?MDM3ODgtNzAwNjMwLTcwMTIyMC03MDEyMzYtNzA1MTAyLTcwNDcx?=
	=?us-ascii?B?Mi03MDA3ODItNzA2MTE0LTcwMjEyNi03MDY4OTEtNzAzMTU3LTcw?=
	=?us-ascii?B?Mjg2NS03MDA4NDktMTQ4MDM5LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77679>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 20 Mar 2008, Brandon Casey wrote:
> 
>> Add support for creating a new tag object and retaining the tag message, 
>> author, and date when rewriting tags. The gpg signature, if one exists, 
>> will be stripped.
>>
>> This adds nearly proper tag name filtering to filter-branch. Proper tag 
>> name filtering would include the ability to change the tagger, tag date, 
>> tag message, and _not_ strip a gpg signature if the tag did not change.
> 
> I think such a change in semantics merits a new option.

I had understood the current behavior to be a shortcoming rather than
desirable behavior.

The change this patch introduces is not the stripping of the gpg signature,
it is the new ability to _retain_ the properties of a tag object. Current
behavior discards everything, including the signature.

If people expect the current behavior and would not welcome this new behavior,
then maybe a new option is needed, but I'm not convinced yet. I'm thinking
that maybe converting a tag object into a light-weight tag should be the special
operation (if that is desirable).

-brandon
