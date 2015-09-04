From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: don't show Done with --quiet --porcelain
Date: Fri, 04 Sep 2015 14:42:08 -0700
Message-ID: <xmqqbndhg8un.fsf@gitster.mtv.corp.google.com>
References: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
	<xmqqvbburrkf.fsf@gitster.mtv.corp.google.com>
	<CA+WR+g7V0Rez_oug5P_LDmafQKXqnDHDNN_vk=-1Sbj3-754DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, "Larry D'Anna" <larry@elder-gods.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Josh Rabinowitz <joshr@joshr.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 23:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXykQ-0002St-HF
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933830AbbIDVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:42:11 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35804 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738AbbIDVmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:42:10 -0400
Received: by pacfv12 with SMTP id fv12so35964883pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bP2YRi65L5ITlLu3Z5siHhEXqIswORY4DjYulmVj3sg=;
        b=Dmn4ymU83OMbk19UK9Ul9ZbtuopEYQniZFT1AHyqHYpWLQ9OK/8xnxNilRB2fan8ns
         JlvkyS635sEM4oNM7K89i0mUaGrYXclCpfsFWmaV91QKHZ3dYkmhUz/nJmr4beR4D5JD
         AdaiNgboVCFoK5hL2adVUfLID674pG2N8o/2CCS3thlS/88B7ZJeyTRYF6qFBD/sYsGx
         AFg5yRzH/bYSmBXoYhPZruRg/JLGpdaNigZTuChDBFUr3F7vbO+RHpTQzK+EBLyOX3+x
         67D3EodKZl3Lg50DSl1rOjwcsEDbuU6fnpmhQnQ44krh1liTSteS28vZtr2I5K7oEh4d
         JzBQ==
X-Received: by 10.68.197.196 with SMTP id iw4mr12663258pbc.153.1441402930041;
        Fri, 04 Sep 2015 14:42:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id h15sm3059745pdk.29.2015.09.04.14.42.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 14:42:09 -0700 (PDT)
In-Reply-To: <CA+WR+g7V0Rez_oug5P_LDmafQKXqnDHDNN_vk=-1Sbj3-754DQ@mail.gmail.com>
	(Josh Rabinowitz's message of "Fri, 4 Sep 2015 09:11:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277338>

Josh Rabinowitz <joshr@joshr.com> writes:

> Hi Junio and other recipients:
>
> Junio, thanks for your response. I think you may have misunderstood my
> patch though (or I am misunderstanding your responses), because it
> seems we are actually in agreement.
>
> 1) My original patch is to make 'git push --porcelain --quiet' not
> emit 'Done' when there is no error. It would continue to emit "Done"
> when using 'git push --porcelain' without an error.
>
> 2) In your first paragraph, you seem to state that while printing
> "Done" is advantageous when using 'git push --porcelain' without
> --quiet, the "Done" output isn't needed when --quiet is used. This
> appears to agree with my patch's intent.
>
> 3) in your second paragraph, you seem to agree with me again, that
> "Done" is not needed when "git push --porcelain --quiet" is use
>
> 4) Then in your third paragraph, you say that you don't want to remove
> the "Done" output when using "git push --porcelain" without --quiet --
> which my patch preserves (again, it would only remove the "Done" text
> when 'git push --porcelain' is used with --quiet and there is no
> error.)
>
> In summary, I think we are in agreement that this patch is probably
> acceptable. Look forward to reading comments.

I think your 4. misinterprets what I meant to say.

Even if we agree 1 thru 3, changing the output, with or without
"--quiet", is an unwelcome thing to do to existing scripts.
