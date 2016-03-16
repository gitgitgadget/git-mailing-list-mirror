From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 03:11:43 +0530
Message-ID: <CAFZEwPMGBKCfEoo2ofCak25jDMRwWwq=1HmgqSyPEpJWhOL_6g@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
	<CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:42:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJCa-0001fi-VI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbcCPVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:41:57 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36042 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965007AbcCPVl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:41:56 -0400
Received: by mail-yw0-f175.google.com with SMTP id g3so78442880ywa.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gGNsMSA8jYooDc8dUsKwzzUViW//M7LnKgyy/pv1TTU=;
        b=Ip+7WO4vHox/8cgpqEYGNUZx2qttXWfhGltqsIVbwQCGsgEzSNnoqFLKGPOSy0uj5Z
         rBZB1RBi7S7f/HXusPE79Z4MxWM8iV/cOUL/0Td7objPP9Nk3mVVQom6Y/BnsQLWuSPA
         Qitc988mRalVHQpcDF2X42kAI3lkTTq4pi/hEy9rRzR8O0OBi1Df77Qg7l1Bh/bn6v3d
         iurL77TiVMuRr5tWc9oUivFy9VU2iU7kl3f4eORF0LRF4ZcSkjHc7wAIkegdxp7Xx/YY
         o0OuQeV6SElFpJjZr8OP/qS08wLZSTEJTNnxiJY5/8h0AK2R7ru5174VgbHwdoHHfgHX
         O+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gGNsMSA8jYooDc8dUsKwzzUViW//M7LnKgyy/pv1TTU=;
        b=YzyhfOF67jcO8iI8Mn7NxrX6TiBCJcSjW43ed5Z7Lm3PC5QENADUqLZklsVOrWBGpP
         JIF4iwvbog07bNorXvC77XZvB0sYjzCCs6eOw50Hm5tmF/c9KZhqUoofQxmPOTvlmxS7
         7VNtdi+wGpQ9yz5dG1WHyRaoAs9Bv3q6bxyxmzp4LyU9wxPKx8+qw7b9pfYEpbnqDpFH
         zBzed++j9+HrskL9mmO1w8R3DX3GGgLVtZkblP3wXk6TftJCz5b3Kyg0ol9yShTef/dO
         A9h6+RlQnb/gRAItPyO4DtAn+CLXRXSuENQ9G+Purwh3ao7rhsnP1O/JblhevzUVP91R
         XlgA==
X-Gm-Message-State: AD7BkJIK+cmDSG7WXqZ7Sn10IoZQG+2Xdkr+rOK60NyeDpo49ZS+pDHh2hjk3THcKNoU7nUAoXpVg62fPZS3iw==
X-Received: by 10.13.252.67 with SMTP id m64mr3079098ywf.67.1458164503165;
 Wed, 16 Mar 2016 14:41:43 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 16 Mar 2016 14:41:43 -0700 (PDT)
In-Reply-To: <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289047>

On Thu, Mar 17, 2016 at 3:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> The goal comes from his GSoC microproject. Specifically, Pranit wants
> an "unspecified" value. The reason is that he is adding a
> commit.verbose=<level> config variable to back the existing git-commit
> --verbose option. Any use of --verbose (one or more times) or
> --no-verbose should override the config.verbose value altogether, so
> he wants a way to know if --verbose or --no-verbose was used; hence
> the "unspecified" value. And, really, this issue isn't necessarily
> specific to git-commit. It could apply to any command that understands
> verbosity levels and wants to be able to get them from both a config
> variable and a command-line option.
>
> A much easier solution would be to update OPT_VERBOSE() to understand
> that negative values are "unspecified", and then --verbose would
> (pseudocode):
>
>     if (value < 0)
>         value = 0
>     value++;
>
> and --no-verbose would:
>
>     value = 0
>
> That should be compatible with existing clients of OPT__VERBOSE()
> which initialize the value to 0, and should satisfy Pranit's case; he
> can initialize it to -1, and if it is still -1 when option parsing is
> done, then he knows that neither --verbose nor --no-verbose was seen.

This is a much easier solution. I didn't think of this. This type of
problem can only arise with only verbose, so it would be better to
specifically change that part of code.
