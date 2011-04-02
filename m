From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pack-objects.txt: fix grammatical errors
Date: Sat, 02 Apr 2011 11:03:00 -0700
Message-ID: <7vy63sh6p7.fsf@alter.siamese.dyndns.org>
References: <1301475606-11339-1-git-send-email-bebarino@gmail.com>
 <alpine.LFD.2.00.1104021155230.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Apr 02 20:03:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q65AO-00022e-7G
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 20:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab1DBSDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 14:03:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab1DBSDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 14:03:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E40F54C22;
	Sat,  2 Apr 2011 14:05:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xoJUS0HNW8zmmDSNqpmCUm/riQQ=; b=SPDlM6
	OYtv3Ihb+w1KeiKtyF3nkGSj0CIZF6f2+hyZAqebsuhruD/hUTeSEkbFNAtvEnpP
	iXgOfZoqj+zC/OT9fDlzNP6/DsmRvs2wM+r3xzG9uF4ZtQu3zUpEvgS1ZhwBkhhz
	VrG5+WLyAqDe7FqnXPhlz3ITE8f79X1hv3VKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NethQ9HzftD22u5ZHqQebvqwx91/vQdR
	h/OY0FGpMn/aPV56Bi4KutOHYyfPGPGxDwN34QUOsTjDObet6xyJiuO6eJC50oIu
	rZdeK/ZK6hSE8NweC1/BeeJNo6fWErVTSWpcgp4uFw3Sr2AptnjXgHpV6+FOiPsE
	qZ2v2X6IZGM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97E144C21;
	Sat,  2 Apr 2011 14:04:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E4A64C20; Sat,  2 Apr 2011
 14:04:53 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1104021155230.28032@xanadu.home> (Nicolas
 Pitre's message of "Sat, 02 Apr 2011 12:03:11 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8353EBE-5D53-11E0-A453-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170656>

Nicolas Pitre <nico@fluxnic.net> writes:

>> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
>> index a51071e..442018b 100644
>> --- a/Documentation/git-pack-objects.txt
>> +++ b/Documentation/git-pack-objects.txt
>> @@ -190,9 +190,9 @@ self-contained. Use `git index-pack --fix-thin`
>>  (see linkgit:git-index-pack[1]) to restore the self-contained property.
>>  
>>  --delta-base-offset::
>> +	A packed archive can express the base object of a delta as
>> +	either a 20-byte object name or as an offset in the
>> +	stream, but older versions of git don't understand the
>>  	latter.  By default, 'git pack-objects' only uses the
>>  	former format for better compatibility.  This option
>>  	allows the command to use the latter format for
>
> This is misleading and not even true anymore if not using pack-objects.  
> Most people are using either 'git repack' or even 'git gc', and the 
> default is to use this parameter since commit 22c79eab.

This page is on the pack-objects plumbing, and in that context there is
nothing misleading nor false about it.

We may however want to do something like the attached to help people who
might wonder how to pass this option through the Porcelain they use.  In
the longer term, it probably makes sense to make the option default at a
version bump, perhaps at the 1.8.0 boundary.


 Documentation/git-pack-objects.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a9c373c..96684bc 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -192,13 +192,18 @@ self-contained. Use `git index-pack --fix-thin`
 --delta-base-offset::
 	A packed archive can express the base object of a delta as
 	either a 20-byte object name or as an offset in the
-	stream, but older versions of git don't understand the
+	stream, but ancient versions of git don't understand the
 	latter.  By default, 'git pack-objects' only uses the
 	former format for better compatibility.  This option
 	allows the command to use the latter format for
 	compactness.  Depending on the average delta chain
 	length, this option typically shrinks the resulting
 	packfile by 3-5 per-cent.
++
+Note: Porcelain commands such as `git gc` (see linkgit:git-gc[1]),
+`git repack` (see linkgit:git-repack[1]) pass this option by default
+in modern git when they put objects in your repository into pack files.
+So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 
 --threads=<n>::
 	Specifies the number of threads to spawn when searching for best
