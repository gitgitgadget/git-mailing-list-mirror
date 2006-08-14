From: David Lang <dlang@digitalinsight.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 12:08:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141206260.14796@qynat.qvtvafvgr.pbz>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> 
 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com> 
 <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com> 
 <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>
 <9e4733910608141148t636f9874wfcf66b56161352c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 21:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GChoI-0000ct-Pk
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWHNTJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHNTJG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 15:09:06 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:31106 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932529AbWHNTJE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 15:09:04 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 14 Aug 2006 12:09:04 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 14 Aug 2006 12:08:56 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608141148t636f9874wfcf66b56161352c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25376>

On Mon, 14 Aug 2006, Jon Smirl wrote:

> On 8/14/06, David Lang <dlang@digitalinsight.com> wrote:
>> On Mon, 14 Aug 2006, Jon Smirl wrote:
>> 
>> > On 8/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> >> I still think that this is important to think through: Is it worth a
>> >> couple of kilobytes (I doubt that it would be as much as 1MB in 
>> _total_),
>> >> and be on the unsafe side?
>> >
>> > The only "unsafe" aspect I see to this is if the global dictionary
>> > doesn't contain any of the words in the documents being encoded. In
>> > that case the global dictionary will occupy the short huffman keys
>> > forcing longer internal keys.  The keys for the words in the document
>> > would be longer by a about a bit on average.
>> 
>> the other factor that was mentioned was that a single-bit corruption in the
>> dictionary would make the entire pack file useless. if this is really a 
>> concern
>> then just store multiple copies of the dictionary. on a pack with lots of 
>> files
>> in it it can still be a significant win.
>
> Bit errors can mess the pack up in lots of ways. If it hits a commit
> you won't be able to follow the tree back in time. Packs were never
> designed to be error tolerant.

I'm not claiming that this is a problem, I'm reponding to other people's claim 
that useing a global dictionary for a pack is a problem becouse if something 
happens to that dictionary the whole pack is worthless by pointing out that, if 
this is viewed as a real problem, it's easy to solve.

David Lang
