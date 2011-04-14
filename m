From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 16:00:58 -0700
Message-ID: <7vd3kofnf9.fsf@alter.siamese.dyndns.org>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
 <201104141524.15212.wjl@icecavern.net>
 <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:01:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAVXI-0005cA-Vw
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 01:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab1DNXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 19:01:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab1DNXBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 19:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D00A75F5F;
	Thu, 14 Apr 2011 19:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWCMfq0NHTLV2klyJhgNVIShXkI=; b=KKnSPp
	Zt6/ZpGOJUMsY8j0rfYZZBOYf9wAO/tN3UmmZvckm4CfdiilYH0xYoIrl+oo3PAs
	Kn2BHcdxagKLA+eQ+HclANpDROjqN2jbdykgRLFDI8+1hRG5vYlH9gb7CVQ6H09F
	miI1gdfjMqvVaEaTjR44ZjeertSKyGqfvo/NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kt6tAucTKJBfEIzGJ1AcYC8beU19DF9o
	Is+zGqmK03kOQW8gcwff8cR6LX/OD4IKp0K0tZiL8wCTSv3CT+F3MMBDq+kYmj4U
	GFfyP+pr651d/N1J4Xu43Uv/x6phSTcakO6iRgSN4aU/rvZKflzprJYp5KHC6w7s
	hAJua9TvO/A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EDB55F5E;
	Thu, 14 Apr 2011 19:03:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B9305F56; Thu, 14 Apr 2011
 19:02:58 -0400 (EDT)
In-Reply-To: <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com> (Chris
 Patti's message of "Thu, 14 Apr 2011 17:31:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 597B30E4-66EB-11E0-A784-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171572>

Chris Patti <cpatti@gmail.com> writes:

>> git branch -D next-release
>> git branch next-release release-3.15
>>
>> (I personally think branches are nicer for this since tags are "supposed" to
>> be immutable.)
>
> Won't either of those things create a 'next-release' that's frozen in
> time where the release-3.15 branch is *right now*?

I suspect that most people go about this the other way around.  You keep
the next-release branch that goes forward, and your automated process
would follow that one.  When you really cut a release, you tag the tip of
next-release, i.e. "git tag v3.15 next-release", to give it a name.
