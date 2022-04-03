Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD1EC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiDCNXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiDCNXr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:23:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BC2FFEE
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:21:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q11so8292120iod.6
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBNFUBKavFGLrBQzsX0IphXxcvP3TPcJgolukJP/Jn0=;
        b=gZAis/lyp/ivLhOfM20EIAGUQPE6wDaTD3Z1WW5txFWkaWo/aQcvPSEtqXe8GyJmPW
         VmYrMRns7kAN6CC9L6j+lUp+ILdVhN/3nVomuBKcKVzY+PkGP41Lf4WTj//KDCbjdUEt
         BiJOtIQnJ42u7jmNRO8ZOR1FEFB3rjIznCRM2iUy5gIPu1ElNOtHRjPTKH/jDY0/TZr0
         P0U6tuLHCbhL5kCR23rhIwp4JLuBVX3ZX+txfI4M5hnL/y6gWtEtCuMISaj5kDmykVf/
         6JepW7Cs0a4em80MYRqnqqVF1TBmPIHx8KWf1o3uBTjhTpSak2sWtSm71P2n4z137bFD
         czdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBNFUBKavFGLrBQzsX0IphXxcvP3TPcJgolukJP/Jn0=;
        b=vyC6KNnTAE2zrmGpTeOJakzr0Qr1lr7yrBmip8p3tW/1TeIs7wes8Lkp849RADmfaO
         znBAv0+xPrmdTTcWAnWF+D3kFKG8w12KR6vdJ51VCnYvsyj9cyTUGLXoQYOFfhnwTzhz
         OOqjVjD086WBxlmeGnyBFYunwe0Seds+3DrlkGVWFxUufyrVJpSCC4UQutgxPVVq+cc7
         sybsNpVr7x8/SY8bCNM1lXTvo6bHDjIzHXLRsivxVCZHftUVScgfsgBSFafvXLD5dVNG
         MSkqI4kVzWq0/yqnHR96UD/488GT3aIDLBcqKMOgIo9maIxte5awKPfHcaKRP9KkCGjP
         lAVQ==
X-Gm-Message-State: AOAM530xVQOGurdFnx2hJslTQ1w3NO6G4LJmdZ4JgsX+fMnuKvoe2V+L
        HzNFcjiPEEyGSb2o5zeZdLEz3xB0RE0YU2p8Wc9559HPigDeKw==
X-Google-Smtp-Source: ABdhPJwy/QUE8LXtX1gOHipf6hzFzAxxO8GduzM7h5kJORLrQYV/NKjxjAKUqZt5MQNRAhAHYVx8osI2BU4KCz6Pxr8=
X-Received: by 2002:a05:6638:1685:b0:323:9fed:890a with SMTP id
 f5-20020a056638168500b003239fed890amr9618272jat.103.1648992112128; Sun, 03
 Apr 2022 06:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   xing zhi jiang <a97410985new@gmail.com>
Date:   Sun, 3 Apr 2022 21:21:40 +0800
Message-ID: <CAN_FRNKbQAFr5fL-giffKADHjBN2QUt5fUQriTpjOv-g5=9QHw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply. Because I was busy last two weeks. And
grateful for your review.

On Tue, 15 Mar 2022 at 01:20, Glen Choo <chooglen@google.com> wrote:
>
> > diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
> > new file mode 100644
> > index 0000000000..0cc0bf54e7
> > --- /dev/null
> > +++ b/t/t4018/javascript-function
> > @@ -0,0 +1,4 @@
> > +function RIGHT(a, b) {
> > +
> > +  return a + b; // ChangeMe
> > +}
> > diff --git a/t/t4018/javascript-function-2 b/t/t4018/javascript-function-2
> > new file mode 100644
> > index 0000000000..06cfb779f0
> > --- /dev/null
> > +++ b/t/t4018/javascript-function-2
> > @@ -0,0 +1,10 @@
> > +function test(a, b) {
> > +  return {
> > +                     RIGHT: function () {
> > +                             currentUpdateRemovedChunks.forEach(function (chunkId) {
> > +                                     delete $installedChunks$[chunkId];
> > +                             });
> > +                             currentUpdateRemovedChunks = ChangeMe;
> > +   }
> > +  }
> > +}
>
> There is also the ES2015 'method shorthand' syntax [3], e.g. `bar` in:
>
>   const foo = {
>     bar() {
>       console.log('hi');
>     }
>   }
>
> [3] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Method_definitions
>
The ES2015 method shorthand is already matched by the regex for
function in class
"^[\t ]*((static[\t ]+)?((async|get|set)[\t
]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)"
So I update the comment for this regex in the v3 patch. The comment is
"/* match function in class and ES5 method shorthand */"

> > diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javascript-function-belong-to-IIFE
> > new file mode 100644
> > index 0000000000..6e5fe858c0
> > --- /dev/null
> > +++ b/t/t4018/javascript-function-belong-to-IIFE
> > @@ -0,0 +1,6 @@
> > +(function () {
> > +  this.$RIGHT = function (needle, modifier) {
> > +      let a = 5;
> > +      return ChangeMe;
> > +  };
> > +}).call(aaaa.prototype);
>
>  Does the IIFE matter in this case? This line:
>
>   this.$RIGHT = function (needle, modifier) {
>
> looks extremely similar to the previous test of `foo = function bar()`.
>
> Or perhaps this is meant to demonstrate the edge case of "matching in a
> complicated construct"? If so, perhaps we should test other edge cases
> like:
>
>    function WRONG() {
>      let RIGHT = function (needle, modifier) {
>          let a = 5;
>          return ChangeMe;
>      };
>    }
>
Currently, I realize this test case is redundant. Because I trust the
function keyword. So the regex "^(.*=[\t ]*function[\t
]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n" is loose for LHS.
I will remove this case in the v3 patch.
