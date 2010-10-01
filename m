From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 03/15] t100[12] (read-tree-m-2way,
 read_tree_m_u_2way): add missing &&
Date: Fri, 1 Oct 2010 05:27:24 -0500
Message-ID: <20101001102724.GB6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-4-git-send-email-newren@gmail.com>
 <7v8w2ko14p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 12:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1ct8-0002ow-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 12:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0JAKac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 06:30:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34999 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab0JAKab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 06:30:31 -0400
Received: by iwn5 with SMTP id 5so3654154iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zcgdsa78xrgvevRU97YyqWA/vN+mxBCO7cdgfHBSZrA=;
        b=FaeVfextZGnlZWW5dMUELznH0BpbQSNyDf6iXPX/RlfMUPo825OM4YvO6GE2GVKmPs
         Z4Vh0932akLTZfUwLTrwPPlhSjKmSjKMySugEoEafDvve1mdLKpIJTu2SVZop3FeJXh4
         TR5gdF57PH/7BYlFQM5eG66gJhf15AwNTx/j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ub1PLnSTBPaQ925vvCZSyCdMGeoOxO0J9xWoG0wghHe4mRkSyaC/7GzpUPsilA/TA7
         DN4Td9iiRvb2IbC5HCitog2NH06gVYL27cLRDSUS6SjHxQ7TufpszXpOYgKGnmRf4Gxe
         6nHzwMaV9XE22SiiiNyVzaVtjG5wBceTf6Jjc=
Received: by 10.231.10.134 with SMTP id p6mr5429373ibp.50.1285929029977;
        Fri, 01 Oct 2010 03:30:29 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm1055286ibh.16.2010.10.01.03.30.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 03:30:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w2ko14p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157739>

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:

>> --- a/t/t1001-read-tree-m-2way.sh
>> +++ b/t/t1001-read-tree-m-2way.sh
>> @@ -98,8 +98,8 @@ test_expect_success \
>>       git checkout-index -u -f -q -a &&
>>       git update-index --add yomin &&
>>       read_tree_twoway $treeH $treeM &&
>> -     git ls-files --stage >4.out || return 1
>> -     git diff --no-index M.out 4.out >4diff.out
>> +     git ls-files --stage >4.out &&
>> +     test_might_fail git diff --no-index M.out 4.out >4diff.out &&
>
> Shouldn't this be must-fail, as we are expecting to see some differences?

I see you've fixed this up already.  Thanks.
