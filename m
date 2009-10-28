From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Wed, 28 Oct 2009 00:29:47 -0700
Message-ID: <4AE7F2EB.1020904@gmail.com>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com> <20091027185223.GH10505@spearce.org> <4AE7A1B9.5010001@gmail.com> <7v63a0t29l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N335W-0005Yn-01
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbZJ1Hgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbZJ1Hgr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:36:47 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49729 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZJ1Hgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:36:47 -0400
Received: by ywh40 with SMTP id 40so417576ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=oXcs88AkK4QmoHg/V8H+6SbQOuSskrj59AUaM1AjUew=;
        b=Q6ETY7+hfRci3304h9FW8hExcql/4B7OxY9zphhwfYYSrbOZAyq1SJco5stn2LWdr+
         7ET+y35VNNvjRJNRiSkm1SI1Ryedwdzil1YhpbV/hCzkofjzSQuKZuO5TghhAZhZQBpT
         VXJoBTJ3o/8wVe6hxVG5YgXU5NFlHVSQYeP34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=I2c4OoADTFvaorFxRnhJ/a9rW177/Rz0B1BPzIfmDKfzsgOCwUH0E+x7nq+C+iHMsf
         1vUwADMj4jApL1sk0HhT7CaiQBkZvPOOCgjabdnj1kkCpA17E3sgbZ5rOcvAqphWUKUt
         hVSCo1OzzvcMiSfRck93lMUoaEPbq2628lTrw=
Received: by 10.150.38.5 with SMTP id l5mr276375ybl.284.1256714990394;
        Wed, 28 Oct 2009 00:29:50 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 14sm356938gxk.10.2009.10.28.00.29.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 00:29:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <7v63a0t29l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131432>

Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>> Ok. Following Junio's suggestion I think we would have to do the following:
>>
>> (1) Revert the rename (git-completion.bash.in -> git-completion.bash)
>>
>> (2) Add a "generation" mode to git-completion.bash.generate to
>> generate the lists and output them to a file
>>
>> (3) Add logic in git-completion.bash.generate to source the generated
>> file if it exists
>>
>> (4) Source git-completion.bash.generate in git-completion.bash to get
>> the functions moved there
>
> Sorry, I do not quite see why an extra *.generate script is necessary.

I'm still assuming the generation mode has to be sh agnostic, therefore 
requiring those functions to be in another *.generate script. Is that wrong?
