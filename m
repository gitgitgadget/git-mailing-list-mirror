From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Thu, 08 Oct 2015 00:13:04 +0200
Message-ID: <561598F0.8050004@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>		 <1443477738-32023-43-git-send-email-dturner@twopensource.com>		 <56129B77.1030409@alum.mit.edu>	 <1444182660.7739.77.camel@twopensource.com> <561564EC.8070704@alum.mit.edu> <1444245629.8836.12.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:20:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjx4L-00012j-AU
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbbJGWUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:20:10 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:49758 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754867AbbJGWUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 18:20:09 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2015 18:20:09 EDT
X-AuditID: 12074412-f79a76d000007c8b-05-561598f284c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 25.D9.31883.2F895165; Wed,  7 Oct 2015 18:13:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9720C.dip0.t-ipconnect.de [79.201.114.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t97MD477028889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 7 Oct 2015 18:13:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444245629.8836.12.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1P00QzTMYM89ZYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BlvPvYyFrwSrmh+NJexgfENfxcjJ4eEgInE
	jAWzmCFsMYkL99azdTFycQgJXGaUmH1pIwuEc45JYteKfkaQKl4BbYnH7WtZQWwWAVWJpUeu
	sIDYbAK6Eot6mplAbFGBIIkVy19A1QtKnJz5BKxGBKh39pEeoF4ODmYBcYn+f2BhYQFLicOP
	G1khdi1mkniwuYMFpIZTwELi2X4VkBpmAXWJP/MuMUPY8hLNW2czT2AUmIVkwywkZbOQlC1g
	ZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKoQjsY15+UO8QowMGoxMMb
	YCYSJsSaWFZcmXuIUZKDSUmU93+XaJgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6jZUA53pTE
	yqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3jPTgRoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQZEaXwyMVZAUD9DeUyDtvMUFiblAUYjWU4yKUuK8V0ASAiCJ
	jNI8uLGw9POKURzoS2HeNSBVPMDUBdf9CmgwE9DgfnkhkMEliQgpqQZGpYLcuAd/55ktMnzO
	eS3WJ+Vc8s3D+65OM3L5fVB72e4j9zxvZlWtvH24bmngv8qey2aZ7arsq2U5hfMyyrpL2zf7
	hM9kfO7yaH6/zqZlrG4nFnolTU13OBsp+/Auw4u/KtMuKrnwrxZpdbg/RXv2Qqvd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279206>

On 10/07/2015 09:20 PM, David Turner wrote:
> On Wed, 2015-10-07 at 20:31 +0200, Michael Haggerty wrote:
>> [...]
>> I'm really happy about your work.
>>
>> Regarding strategy: I think a good approach would be to get as much of
>> the preparatory work as possible (the abstraction and separation of
>> refs-be-files) to the point where it can be merged before there is too
>> much more code churn in the area. That work is not very controversial, I
>> think, and letting it wait for a long time will increase the likelihood
>> of conflicts with other people's changes. The refs-be-lmdb patches, on
>> the other hand, (1) will take longer to get polished, (2) will take
>> longer to review because other people are not familiar with LDMB, and
>> (3) won't bitrot very fast anyway because they don't overlap as much
>> with areas that other people are likely to work on. So I would advocate
>> working on those at a more deliberate pace and planning for them to be
>> merged as a separate batch.
> 
> Works for me.  
> 
> Would you like me to start sending those as a separate series, or shall
> I keep it as one series and let you split it as you choose?

That's really up to you, as the convenience tradeoff is mostly on your
side. If you keep it as one series it is a tad easier for everybody to
see the whole idea as a continuous story. But it means that whenever you
rewrite any commit in the series, you have to propagate the change
through all of the commits, every time. Whereas if you break them up,
you have the option of letting the later patches idle for a while then
to rebase them onto revision N of the earlier patch series in one big bang.

BTW I didn't have the impression that the series has to be broken into
more than two or three subseries. Splitting off refs-be-files.{c,h} from
refs.{c,h} and creating the virtual function table is pretty much one
unit of work and I see no sense splitting it artificially into separate
parts. Adding refs-be-lmdb.{c,h} is only a couple of (big!) patches
which, again, don't really need to be split any further. If you decide
to implement the delegation thing for handling the split between
per-worktree vs. shared references (even when both use the files
backend), that might be a third patch series between the other two.

The best dividing line to choose is between "uncontroversial" and
"possibly controversial", because the former are more likely to succeed
in a fast track.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
