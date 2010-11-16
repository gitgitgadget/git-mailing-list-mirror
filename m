From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick -x formats the message incorrectly
Date: Tue, 16 Nov 2010 13:35:04 -0600
Message-ID: <20101116193504.GB15828@burratino>
References: <loom.20101116T100730-967@post.gmane.org>
 <7vpqu5gjmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Svensson <martin.k.svensson@netinsight.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:35:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIRJm-0004Hm-0f
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab0KPTfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:35:45 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44612 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab0KPTfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:35:44 -0500
Received: by gwj17 with SMTP id 17so616510gwj.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XPJ5cd5HhOwMPnSMTt66aV7ma3n4q7JaCHBz4jt6M9o=;
        b=sRT1cm0jLkep/TIWjgEpe7G3LKN04K+wdhwHY21sYybGKoSR0yUte0nPholB4B89OK
         t4Icn/Cc3mI/n8sJtpmbz3tB3vZ3RiOFZHtbsa6tHyWoMMsbzX+/AxROx+9pezPS/tPv
         RzK06oJKTVi+FNJGRibzt9JUFenSdc6skSGeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RllDrRzS6Sa1vpB+APmiujIISyX7rkV0lPk2uIVR8yjkJKiFU/PE8d5WwxdPCA2v+w
         FNhxL2Y1BKGWglyB27bpRoCc1IuCwyyfUiJP/gAcIiK2v7Sv9xdPNm80SirEGff5gpYn
         qRECH+qS1ugeCmdAcaTmGkVRphFjRHaDRyP1M=
Received: by 10.223.69.134 with SMTP id z6mr6560242fai.19.1289936142932;
        Tue, 16 Nov 2010 11:35:42 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j8sm1431765fah.30.2010.11.16.11.35.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 11:35:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqu5gjmv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161581>

Junio C Hamano wrote:
> Martin Svensson <martin.k.svensson@netinsight.se> writes:

>> It should be:
>>
>>   foo
>>   
>>   (cherry picked from commit eb42a6475d2c2e4fff7a1b626ce6e27eec21e886)
>>
>> Am I right?
>
> I tend to agree (modulo s/summary/subject/ would be the wording I would
> have used).
>
> This falls into "patches welcome" category, though.  I do not think
> anybody sane is still using cherry-pick with -x option these days after
> http://thread.gmane.org/gmane.comp.version-control.git/28378

Mm, I use it and do not agree; I think the rule should rather be:

 - if there is a Signed-off chain, quietly integrate into that (no added
   newline)

 - if there is not a Signed-off chain, add the extra newline.

Patch for a related issue in a few minutes.
