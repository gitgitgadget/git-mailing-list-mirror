Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212021F453
	for <e@80x24.org>; Mon, 18 Feb 2019 04:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBREe6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 23:34:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBREe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 23:34:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so5437376pgl.0
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 20:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jMUYF94GVSSmCZmBhszB12uW0+xsST28Mj4MCCXpiE=;
        b=qnNGhUdWUjpYeHPzFwpBa+gSIqlTUTJjOBjrs12FgRG6gUQA/fiTW4jCWjHo31Fmq9
         rs8m4oeuQyXMBb9451EZcsc15eEvIsdNsOC9ADqovOhmcAbUVgti71xHteFl2yvScd5D
         ThqekmD0qfH54P6A8ZyihSbIKFikCoc5db89AQ9Na9h71jI6Od5YF6DX7pwXqnXk7fsn
         PHc3vZ/n1mCSX5ZPNJS48j5qp8Evjx+mC9j9BdtCTE2JicICuGgiJ8ZZUdMyGUXGcpm0
         XGVhPdG7/9SzGDysQUUN1iL/VoMl+95iY+1w1dqyJm1Unl9WgTpNWnI5zNCipJNjPa/x
         TfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jMUYF94GVSSmCZmBhszB12uW0+xsST28Mj4MCCXpiE=;
        b=dLIkR/S26DaDAz/R0WkHgdc7j7swtgvoWZEH2pODpRIHYIUjrv8S8ulHsbzLO9ZDiR
         CTEP9XW6VqfzbHdIEnS6XscipsnLGAL/a8gJPaBsojFi/9m+rXapP7kOFSkSbZj3e/Zn
         I3Xfk0BZkwcXFjyheuvwT+EOLjm4/Y3Eox87cAMq40bxgo0LL3YYhGat1L6sdBhfvF+2
         ox5SGnfc1EkLw51HJLlM8eqP0h3VGP3j2aI4das6TrQVAbrpykoG5pwdpw6SH/204ssA
         uu8MpjXQDS9aK1NF0gQOk1ahJn1DYLhvF43Cs3OXWLthGgcaBoTTzAGhoSQOSvZYOVrP
         MPFw==
X-Gm-Message-State: AHQUAubphdC9MYgIN2aisL96/driVHkZJWY2DXNmiBDbaezzZ/BZvTuy
        58c43Xb58i1Ru2u03lc/dsAMTp3ZUkE=
X-Google-Smtp-Source: AHgI3IaXYhKxhCSGchwsClzYY8MtFvFI7n/pWILdDI4//szwMRXmYy+66uXUM2eo5TgKWJoUzWEORQ==
X-Received: by 2002:aa7:854d:: with SMTP id y13mr22267268pfn.175.1550464496816;
        Sun, 17 Feb 2019 20:34:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d131sm19271269pfd.108.2019.02.17.20.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:34:55 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:04:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>, vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
Message-ID: <20190218043453.b3jkt365bvg2deox@vireshk-i7>
References: <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <20190215064013.s7yfkmfvfmwfmepc@vireshk-i7>
 <CABPp-BFpj8DBxgsqe9Rqnzb4vx5fPqNc+sUj8LzrFMj2bacoBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFpj8DBxgsqe9Rqnzb4vx5fPqNc+sUj8LzrFMj2bacoBQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15-02-19, 08:09, Elijah Newren wrote:
> Hi Viresh,
> 
> On Thu, Feb 14, 2019 at 10:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-02-19, 13:23, Elijah Newren wrote:
> > > I think you're getting tripped up by double-dot vs triple-dot with
> > > diff being different than log:
> > >
> > > `git diff D..E` means the same thing as `git diff D E`, i.e. diff the
> > > two commits D and E.
> >
> > Right, so both the branches have at least until rc2 (though
> > pm/linux-next had until rc6), why will the diff D..E show the diff
> > between rc1 and rc2 ?
> 
> I don't think it does; it includes the diff between rc2 and rc6.
> First, `git diff D..E` will show you roughly the same thing as if you
> have two clones of linux, one with D checked out, one with E checked
> out, and then you run 'diff -ru linux-copy1/ linux-copy2/'.
> 
> But let's go back to your example, you had
> 
> Branch A: commit 55538fbc79e9
> Branch B: commit a4f342b9607d
> Branch C: commit 7c139d3f0f99
> Branch pm/linux-next: unspecified, but I'll guess commit a06639e89e4

I mentioned that at the bottom of the email, d26ff2405272 :)

And yes I got confused somehow earlier, ran all the commands again to
verify the diffs, sorry about that.

-- 
viresh
