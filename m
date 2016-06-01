From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 02:39:34 -0400
Message-ID: <CAPig+cRTnbjN2S5RLyPaNDdUT6pTig4==JbMUgVtaBKcaWy52g@mail.gmail.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
	<20160531225628.GA4585@sigill.intra.peff.net>
	<CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
	<20160601023159.GA5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:39:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7zoa-0000eu-5U
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 08:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbcFAGjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 02:39:36 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37215 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbcFAGjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 02:39:35 -0400
Received: by mail-it0-f48.google.com with SMTP id z123so11929672itg.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=P2yL9obpIV7+QXUWose3A7CaWgKkKHuI8Yq3Jg61QjY=;
        b=imagyM1SscE2Uly4J22Ul48eInq1YGtwUY9YoHQgB6N3X4U+1Gk4wvnV/t/TReliF6
         4JC7nNiWoxpgSCR39E9aHziI1IPgPUpFNW3VSlco54l58jG3D53KKG4WhJshp7TYISc9
         AF9hjyYTG+vfI2VaOdGrVLTecQ2aKK6orgZrHt6YJXxyrtflFNnewxx6oCBIYKyxBeep
         qoyiJtQ8ldgH/zSa5BYGKxIQ78CmtKDvWS3R6Gwlhqy7S0c76Wn1vgPUO1S1L0a1ASLy
         l3VMws3V1U1ottjLFFfgw2th7TXO+BAx9okhaBI/M5Hqz+C4whd21+n7MM0dPjSqrpNK
         mkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=P2yL9obpIV7+QXUWose3A7CaWgKkKHuI8Yq3Jg61QjY=;
        b=d8FXy1PNGdUPui8eduDbIgTusE9elUAhtkOMMkM85imR6DPxjhlZrKMYp9JXXqsc/D
         e8zE+J6OvuIw8IeyfbPCCfEcZR+oSPcGv7Ao03i6ExK7Uic247mwJ0N6ql6hD8syXjJr
         Lp2DtO5kMBkh0OYP0w40j2KDFVAx+tA6SVxGeoUsl/Hqs4309AifB4QaQCWHczhZnJ0z
         w3Wm8hDLMCGgn6bjaDjkyF19fTlVrXsUPh67SRQJxoSIbgOgHTr1yAZF4cW9aQeJEZPc
         vZpHP+RgL0NmJjwT7+Scv39DgwQCBHpghDzmHV0OQ1CZ0u2+P20yoh7zPxWFLgE5OLGH
         93oA==
X-Gm-Message-State: ALyK8tJHl7wz26EbBora4m/xSKGJkAPgFLCwpqv7FI0HbRRz/wPcX4a81yp98S1uemehR/MyXgnwBiWlK84J3w==
X-Received: by 10.36.55.147 with SMTP id r141mr18567771itr.73.1464763174527;
 Tue, 31 May 2016 23:39:34 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 23:39:34 -0700 (PDT)
In-Reply-To: <20160601023159.GA5411@sigill.intra.peff.net>
X-Google-Sender-Auth: hKoEQDoN6brFCMqtPAHLeiBNogM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296055>

On Tue, May 31, 2016 at 10:31 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 31, 2016 at 08:09:43PM -0400, Eric Sunshine wrote:
>> I was under the impression that the project was moving toward 'env' to
>> deal[1] with this sort of issue.
>>
>> [1]: 512477b (tests: use "env" to run commands with temporary env-var
>> settings, 2014-03-18)
>
> We can use it with test_must_fail, because it takes a command name:
>
>   test_must_fail env FOO=BAR whatever-you-would-have-run
>
> But I don't think it works in the general case, as test_commit does not
> run its arguments. [...]

You're right, of course. I should have seen this.
