From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] test: use test_i18ncmp when checking --stat output
Date: Tue, 13 Mar 2012 01:06:17 -0500
Message-ID: <20120313060617.GA16784@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
 <20120313045404.GA12550@burratino>
 <7vzkblkpkk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 07:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7KsZ-000825-IA
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 07:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843Ab2CMGGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 02:06:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59134 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab2CMGGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 02:06:34 -0400
Received: by yenl12 with SMTP id l12so175399yen.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PXFrj2M2i2ys7tfuaOtUOykyw1qOnWiZCKbSH+/Yisg=;
        b=p/Sq5ARvgVuFqKLrCiN8YTz4xD3UxaZQXk+7AgH6AdIZO3f50y1cLmkBY4S5keHN9/
         e+eTRe0//a7XhBacyrYIfBl4KqYWV7OOftqWeDeHbx3/Q3/69GUoHO9TX8CqvLTAhHdo
         vOxazFTTILbhVxrDlbxpkt/n+0+gqOo9H2KAKgA4J982RVVBwOdNWfSjgYSigHxBW7ig
         1eE3sOIc21DjdsLz0ySX0dtN+VGgMSqWL8YvhnmK/MWplu/Ol95/ZLR+xuMoOEGF5pRk
         9tTEduqAqimzzPVr14q6/3DStbHnupQTUxUtQ63gSCQWSNMXo0dYFIoMPQROnPD1Fhxd
         DTkg==
Received: by 10.60.4.106 with SMTP id j10mr9961223oej.47.1331618793509;
        Mon, 12 Mar 2012 23:06:33 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q6sm24577173obz.17.2012.03.12.23.06.32
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 23:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkblkpkk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192983>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/t/t3508-cherry-pick-many-commits.sh
>> +++ b/t/t3508-cherry-pick-many-commits.sh
>> @@ -55,7 +55,7 @@ test_expect_success 'cherry-pick first..fourth works' '
>>  	git diff --quiet HEAD other &&
>>  
>>  	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
>> -	test_cmp expected actual.fuzzy &&
>> +	test_i18ncmp expected actual.fuzzy &&
>>  	check_head_differs_from fourth
>>  '
[...]
> Honestly speaking, I am not sure if we should be making these
> comparisons to cast the informational output from cherry-pick
> that is meant for human concumption in stone to begin with.

You might like patch 4, then. ;-)
