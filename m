From: Noel Grandin <noelgrandin@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 05 Apr 2012 16:39:46 +0200
Message-ID: <4F7DAEB2.8080006@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu> <C15BAB9A-EAFA-4EA4-
 85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm> <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Gummerer <italyhockeyfeed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 16:40:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFnqy-0005Cl-R6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 16:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab2DEOj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 10:39:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34903 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2DEOjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 10:39:55 -0400
Received: by wibhj6 with SMTP id hj6so1705298wib.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yugo+EOz+CeNsaTuioVyLrsC9E8sAAoq8hVBPslBBPc=;
        b=a0hVZBKmD46wjbeaRJZWzCj7y4kTs8EOAjJ5koyN1WxwaVPP/sW9nESVw5mBrBkaze
         aZN+AkS1gCd65E38k9zGcXnxV2a431QFNGnhGqqaMNboWKQAzGQC4BzEs1iN4UVV47Rz
         nvCTihq0LmaaxuD5kfziNpCB+WyexIaBS+L6f3XCkGIHJTXtofB+ObQrvd5uJsvke6iM
         KHx0wcAfC5tCoSe2w4u1r3uPkOl2zkSh2aCedIYpyTlqjAny01Er905G/PHudvWOK66F
         WyOHkUW1PB//89ykbSE48LOpn1qDNtvkizYOn9sCbK3g88GkBbpgrqLo970Cqhn3SXGj
         SwOg==
Received: by 10.180.80.9 with SMTP id n9mr5486985wix.4.1333636794200;
        Thu, 05 Apr 2012 07:39:54 -0700 (PDT)
Received: from [192.168.1.200] ([41.164.8.42])
        by mx.google.com with ESMTPS id n8sm17787904wix.10.2012.04.05.07.39.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 07:39:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194779>



On 2012-04-04 22:05, Thomas Gummerer wrote:
> -- Proposed solution --
> The proposed solution is to redesign the index to a B-tree based format. This
> allows changes to the index in O(log(n)) time, with n being the number of
> entries in the index.
>
Sounds like you're re-inventing one of these:
http://code.google.com/p/leveldb/
http://code.google.com/p/high-concurrency-btree/
