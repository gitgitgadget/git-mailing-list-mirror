From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Sat, 25 Apr 2015 16:52:10 +0530
Message-ID: <553B78E2.5070608@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <20150419002807.GA11634@hashpling.org> <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com> <20150420074433.GA30422@hashpling.org> <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com> <20150420091920.GA31279@hashpling.org> <553520CF.6070304@gmail.com> <20150421101641.GA13202@hashpling.org> <CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com> <xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 13:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlyAF-0007kc-2e
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 13:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbbDYLWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 07:22:16 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33152 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbbDYLWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 07:22:15 -0400
Received: by pdbnk13 with SMTP id nk13so74474092pdb.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g8MNu8+3GqQDLcQhuXSjCRRYI4YPZkzyih9mg+sJOMY=;
        b=X2t9BwhpZwXUzQ1O1V0f+UcJmAKLyDBorA5eCZbiY2TUE2dWXPc+GduOF0ejZa1VwP
         WXgto6V0JbSiwOxak6o0UBdDh9uy97BdP32Z/BL9t7LIXlyZ+bolCw78PC0Vo8QNride
         Pz5xIXBnfPlEFMA6xpW+pLLVtJAnCc/mg7a0lcYv0aldsdOKKEpzAg+WmoQSRf2alzVT
         8GcUdjuLKyK4OC128ydUn0aCBQSro9lFN23XoEdoUMBJiaaCE32Ed6EF1ZRk4kcSZy1O
         7vVzKs8IPRoWY9MjS+jJeOqNwoBjkwbudFqxC5az4uC7gnVoH7PvERBQM3X0yvpB5WbR
         98+A==
X-Received: by 10.70.103.10 with SMTP id fs10mr5298386pdb.141.1429960934826;
        Sat, 25 Apr 2015 04:22:14 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id j14sm13708853pbq.29.2015.04.25.04.22.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2015 04:22:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267788>


On 04/22/2015 02:06 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > It's easy to be blinded into thinking that cat-file's new option
> > should be named --literally since it was inspired by the --literally
> > option of hash-object, but indeed it may not be the best choice.
>
> Yeah, I wouldn't even say "inspired".  It was envisioned as a
> counter-part debugging aid, nothing more.
>
> Is there any other way to make cat-file looser other than accepting
> an unknown type name from the future?  If so, then perhaps it may
> make sense to give it a generic name that implys that we would
> trigger such additional looseness in the future.  But as the
> inventor of it as a debugging aid, I would say a name that spells
> out the specific way this option is being loose, e.g.
>
> >      --allow-bogus-type
>
> or with s/bogus/unknown/, best describes what it currently does.
Yes this gives the best description, but its large, while we could use something
like --no-strict instead. Is the size worth the trade-off for a better description?
>
> Thanks.
>
>
>
