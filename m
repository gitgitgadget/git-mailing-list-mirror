From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 6/7] Switch path canonicalization to use the SVN API.
Date: Thu, 02 Aug 2012 16:18:16 -0700
Message-ID: <501B0AB8.7060401@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino> <5014387C.50903@pobox.com>
 <20120730200444.GB20137@dcvr.yhbt.net> <20120802215141.GA5284@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx4ew-0001Ou-JN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab2HBXSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 19:18:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab2HBXST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 19:18:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8364F9AC8;
	Thu,  2 Aug 2012 19:18:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=a891E+GAIhzG
	PYAvD0MbrNfzufQ=; b=fIg2/CoFeHjwb3mbm3nNVqtJEinu9j6PVN1RVsWvJbXL
	0uM4xhTJzdUiRDMiApLInZCofb5hXmS2RU4VzcnReQpGqLFA/KXgc5xq3sWRmhmx
	qMqN/qrAPZWJ3B4pfvL/OAvJDCBdstiLKv+qcSzVFUp/ogyaBym6xt41z7stjl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WAp1Sp
	D/cWk+pcC84Dn7swN6A/fWfkIcffycDmBFqP3VURMbq9NcG1Zm2dlYuQv88zZbSf
	vROHbVjweL9DAq9lQBFdwohAuuZr/lXM5a/tfTsxyoWaSe4kAM2gHJTTrJwGWN8B
	NLnGEgNAqkkEErMbrKVZgSwTnNECIYaAD+35M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 713239AC7;
	Thu,  2 Aug 2012 19:18:18 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7A49AC5; Thu,  2 Aug
 2012 19:18:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120802215141.GA5284@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 57C6C572-DCF8-11E1-944A-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202814>

On 2012.8.2 2:51 PM, Eric Wong wrote:
> svn_path_canonicalize() may be accessible in some versions of SVN,
> but it'll return undef.

Yuck!  Good catch!


> I've tested the following on an old CentOS 5.2 chroot with SVN 1.4.2:

Looks good to me.


-- 
Alligator sandwich, and make it snappy!
