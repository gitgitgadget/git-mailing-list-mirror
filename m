From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Sat, 2 Apr 2011 16:28:55 +0700
Message-ID: <BANLkTi=QK0_P3=rGFLXzZzk7c7JSNxuBmA@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com> <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 11:29:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5x9B-0006IW-9x
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 11:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab1DBJ31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 05:29:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37971 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1DBJ30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 05:29:26 -0400
Received: by pwi15 with SMTP id 15so851194pwi.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OKEavGsmveUr2xEXpMCpt9j+qsPAssdJpOQDlpNgN4k=;
        b=xpa8Ke2vsFZmEwxmv+yjqJ+BqwMWzfm+wuo0GwoYMRXaKgp5pbqw1//3Q1WiWPgmc0
         /Fq5P610jrYq0XWQ1IYcFhz57yb3C7tV2GoL8v6BeNYlKVO3dT1NRjIzJ41hqxumU98d
         3q0dHm0g0dzWN+q7NIFd1ma5tUb3TYdOavz80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=noIRE3MIf9GCj1I0IXsjLIFw3ZupOdlc1hZaD/0Ga4ind+A6VRgZC8GpWwtP6pqzsL
         JcdkyBwBMUCbYYuUmUhjcnnJ4y1mbLzzUOYBHLlLVtEhUtZr45SRfubBYYxrM4uOp10W
         Mp/BD3as3QMpKy+6IREBTumkSIkv4gIUHz8AM=
Received: by 10.143.87.1 with SMTP id p1mr3878439wfl.271.1301736566092; Sat,
 02 Apr 2011 02:29:26 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Sat, 2 Apr 2011 02:28:55 -0700 (PDT)
In-Reply-To: <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170647>

On Thu, Mar 31, 2011 at 8:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> We know our mode entry in our tree objects should be 5 or 6 characters
> long. This change both enforces this fact and also unrolls the parsing
> of the information giving the compiler more room for optimization of the
> operations.

I'm skeptical. Did you measure signficant gain after this patch? I
looked at asm output with -O3 and failed to see the compiler doing
anything fancy. Perhaps it's because I'm on x86 with quite small
register set.
-- 
Duy
