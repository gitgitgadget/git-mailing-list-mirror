Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC0C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiCNRVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCNRVu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 13:21:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AEA3F309
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 10:20:40 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w68-20020a62dd47000000b004f6aa5e4824so9850717pff.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MSJtwn9ONTSUg4Cnh/azwSPTctmUxYaUqwAaoEDQhlE=;
        b=U6x+HiCiFcHcUid+OL4g/hKFvtQrQ7DZPDqbVWLz/oEX7ZoHlOArRwxEeoVZ9BrWdR
         4fugFFrjQBhXd7DipUFxeb5HzWSnAsQI+KIFnzwR32CIOCnqHHi7R1SayljNe0fxHeh1
         lZ1AI6vC7WhrtpOGRXxuLVNYs1y45Z4km7RzGzFVn55UHi0u5VB6lQ0vaZy5sil18cjM
         pDdxH2UBAocMII1vMNnosgCfn6ve1d5mfK/AsW3rg3xt7hiEJ2/OqQ/i6JRc9vHGKYQw
         TxPHTlg77iUoomHw65lF7Q0zn0DcTJLnZVInnK0PjKvmewy1CTdKgLFYTXxlFOKdDZ3M
         4eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSJtwn9ONTSUg4Cnh/azwSPTctmUxYaUqwAaoEDQhlE=;
        b=XQlKD1R4L1uNQtpbTNs03awv0k+qw27DUVhZjgruulIXFgyVAWsMyETzybKQ0OGsIh
         d0auS6NCKBpY/k647jKdAMTz5rfRSXoiP8GY+TNG8HgSUTa1MTUjMGcWAnSrXOjJJEhQ
         AdGqFcXqpmrCQrf5mJHdlr2AuJwN4PtcFenI75UfGwRh1fp5RBtxj0oZ6OvodV3uUqxB
         SnFqC1cVwxqyQJq+K9VOv0Ldv2XCuRqFIhYBo9ge/Dvo7pnV5d7ZVe9/Yp7bmgNmLgVF
         tx3F7UzmAcoZG0kx0O9N5Q8ojxK+X6RuLNxWGyzTA+aLs8Yk36/M1xZG8cLoVb3YhVtW
         Zt8A==
X-Gm-Message-State: AOAM532d5prFEeyR8VpMoVfOLaoKa+OFREtHS4mOjsvMYcDCUA/lc4O4
        dXjgP8YhMoHiMWXHGquFNBMTwhZLLSBtOg==
X-Google-Smtp-Source: ABdhPJxxIGEdGTZ8iJd+Y7f71tpN162XX7GCcXuUbCFy2BPYQ1UOWH68AyU1iaGq9+J8jcht8buQX9YZ+TY4Xw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3e88:b0:1bf:3bd0:4b5f with SMTP
 id rj8-20020a17090b3e8800b001bf3bd04b5fmr283644pjb.106.1647278439527; Mon, 14
 Mar 2022 10:20:39 -0700 (PDT)
Date:   Mon, 14 Mar 2022 10:20:37 -0700
In-Reply-To: <20220312164803.57909-1-a97410985new@gmail.com>
Message-Id: <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com> <20220312164803.57909-1-a97410985new@gmail.com>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
From:   Glen Choo <chooglen@google.com>
To:     xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
Cc:     j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Welcome to the Git project :) I never realized that we didn't include a
built in JS diff driver, so this would be quite welcome.

I'm not entirely familiar with this part of the system or our regex
style, so I won't comment on those. I'll only comment on the patterns we
are trying to detect and whether or not we want them.

I'm not 100% clear on the style around diff drivers e.g. how do we
decide that we want a pattern or not? I'd appreciate any pointers to
docs or commits.

xing zhi jiang <a97410985new@gmail.com> writes:

> diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4018/javascript-assignment-of-anonymous-function
> new file mode 100644
> index 0000000000..b6f2ccccfc
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-anonymous-function
> @@ -0,0 +1,4 @@
> +const RIGHT = function (a, b) {
> +	
> +    return a + b; // ChangeMe
> +};
> diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/javascript-assignment-of-arrow-function
> new file mode 100644
> index 0000000000..24ce517b7a
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-arrow-function
> @@ -0,0 +1,4 @@
> +const RIGHT = (a, b) => {
> +	
> +    return a + b; // ChangeMe
> +};
> diff --git a/t/t4018/javascript-assignment-of-arrow-function-2 b/t/t4018/javascript-assignment-of-arrow-function-2
> new file mode 100644
> index 0000000000..bbf5de369e
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-arrow-function-2
> @@ -0,0 +1,4 @@
> +const RIGHT = (a, b)=>{
> +	
> +    return a + b; // ChangeMe
> +};
> diff --git a/t/t4018/javascript-assignment-of-arrow-function-3 b/t/t4018/javascript-assignment-of-arrow-function-3
> new file mode 100644
> index 0000000000..4a07aa3259
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-arrow-function-3
> @@ -0,0 +1,4 @@
> +const RIGHT=test=>{
> +	
> +    return test + 1; // ChangeMe
> +};

These are all variable assignments of anonymous functions, so we won't
'technically' be showing the function name in the diff, but as a
practical matter, they are _probably_ referred to by this name
consistently. So including them makes sense.

> diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/javascript-assignment-of-named-function
> new file mode 100644
> index 0000000000..bfc486ebef
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-named-function
> @@ -0,0 +1,4 @@
> +const RIGHT = function test (a, b) {
> +	
> +    return a + b; // ChangeMe
> +};
> diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
> new file mode 100644
> index 0000000000..993e6926bf
> --- /dev/null
> +++ b/t/t4018/javascript-async-function
> @@ -0,0 +1,4 @@
> +async function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
> new file mode 100644
> index 0000000000..fecbd669d7
> --- /dev/null
> +++ b/t/t4018/javascript-export-async-function
> @@ -0,0 +1,4 @@
> +export async function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
> new file mode 100644
> index 0000000000..b5acbb2b08
> --- /dev/null
> +++ b/t/t4018/javascript-export-function
> @@ -0,0 +1,4 @@
> +export function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}

These look good; the 'export' statements are part of the ES modules
feature. I'm not sure if it makes sense to explicitly test these cases
unless we have reason to believe that the 'export' keyword will affect
the matching.

> diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/javascript-exports-anomyous-function
> new file mode 100644
> index 0000000000..6786cbda8d
> --- /dev/null
> +++ b/t/t4018/javascript-exports-anomyous-function
> @@ -0,0 +1,4 @@
> +exports.setFlagged = RIGHT => {
> +	
> +    return ChangeMe;
> +};
> diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/javascript-exports-anomyous-function-2
> new file mode 100644
> index 0000000000..883569f40d
> --- /dev/null
> +++ b/t/t4018/javascript-exports-anomyous-function-2
> @@ -0,0 +1,4 @@
> +exports.RIGHT = (a, b, runtime) => {
> +	
> +    return ChangeMe;
> +};
> diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
> new file mode 100644
> index 0000000000..63b79f5991
> --- /dev/null
> +++ b/t/t4018/javascript-exports-function
> @@ -0,0 +1,4 @@
> +exports.RIGHT = function(document) {
> +    
> +    return ChangeMe;
> +}

I don't think we should include 'exports.foo = bar'. To my knowledge,
this is _not_ a standard ES feature, but rather the CommonJS module
system popularized by Node.js [1] and other frameworks. To confirm this,
I searched the ES spec and did not find any reference to exports.* [2].

Even if we wanted to support nonstandard 'language features' (and this
label is tenuous at best, CommonJS is not trying to replace the ES
modules standard AFAIK), Node.js is also starting to support ES modules,
so I don't think this is a good long term direction for Git.

[1] https://nodejs.org/api/modules.html
[2] https://262.ecma-international.org/12.0/#sec-exports

> diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
> new file mode 100644
> index 0000000000..0cc0bf54e7
> --- /dev/null
> +++ b/t/t4018/javascript-function
> @@ -0,0 +1,4 @@
> +function RIGHT(a, b) {
> +
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-function-2 b/t/t4018/javascript-function-2
> new file mode 100644
> index 0000000000..06cfb779f0
> --- /dev/null
> +++ b/t/t4018/javascript-function-2
> @@ -0,0 +1,10 @@
> +function test(a, b) {
> +  return {
> +			RIGHT: function () {
> +				currentUpdateRemovedChunks.forEach(function (chunkId) {
> +					delete $installedChunks$[chunkId];
> +				});
> +				currentUpdateRemovedChunks = ChangeMe;
> +   }
> +  }
> +}

There is also the ES2015 'method shorthand' syntax [3], e.g. `bar` in:

  const foo = {
    bar() {
      console.log('hi');
    }
  }

[3] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Method_definitions

> diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javascript-function-belong-to-IIFE
> new file mode 100644
> index 0000000000..6e5fe858c0
> --- /dev/null
> +++ b/t/t4018/javascript-function-belong-to-IIFE
> @@ -0,0 +1,6 @@
> +(function () {
> +  this.$RIGHT = function (needle, modifier) {
> +      let a = 5;
> +      return ChangeMe;
> +  };
> +}).call(aaaa.prototype);

 Does the IIFE matter in this case? This line:

  this.$RIGHT = function (needle, modifier) {

looks extremely similar to the previous test of `foo = function bar()`.

Or perhaps this is meant to demonstrate the edge case of "matching in a
complicated construct"? If so, perhaps we should test other edge cases
like:

   function WRONG() {
     let RIGHT = function (needle, modifier) {
         let a = 5;
         return ChangeMe;
     };
   }

> diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-function-in-class
> new file mode 100644
> index 0000000000..0cc0a26612
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
> new file mode 100644
> index 0000000000..725495fe55
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-class-2
> @@ -0,0 +1,11 @@
> +class Test {
> +  RIGHT(
> +      aaaaaaaaaa,
> +      bbbbbbbbbb,
> +      cccccccccc,
> +      dddddddddd
> +  ) {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-function-in-class-3 b/t/t4018/javascript-function-in-class-3
> new file mode 100644
> index 0000000000..e9b20728b2
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-class-3
> @@ -0,0 +1,10 @@
> +class Test {
> +  RIGHT(aaaaaaaaaa,
> +      bbbbbbbbbb,
> +      cccccccccc,
> +      dddddddddd
> +  ) {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-function-in-object-literal b/t/t4018/javascript-function-in-object-literal
> new file mode 100644
> index 0000000000..021cc706dd
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-object-literal
> @@ -0,0 +1,7 @@
> +const obj = {
> +    RIGHT: function (elems, callback, arg) {
> +        var length, value;
> +        // ...
> +        return ChangeMe
> +    }
> +}
> diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
> new file mode 100644
> index 0000000000..dc7793939f
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function
> @@ -0,0 +1,4 @@
> +function* RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
> new file mode 100644
> index 0000000000..950676a612
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-2
> @@ -0,0 +1,4 @@
> +function *RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-getter-function-in-class b/t/t4018/javascript-getter-function-in-class
> new file mode 100644
> index 0000000000..9a5aee39f7
> --- /dev/null
> +++ b/t/t4018/javascript-getter-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  get RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-setter-function-in-class b/t/t4018/javascript-setter-function-in-class
> new file mode 100644
> index 0000000000..dc5f288665
> --- /dev/null
> +++ b/t/t4018/javascript-setter-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  set RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-skip-function-call-statement b/t/t4018/javascript-skip-function-call-statement
> new file mode 100644
> index 0000000000..321993c27e
> --- /dev/null
> +++ b/t/t4018/javascript-skip-function-call-statement
> @@ -0,0 +1,7 @@
> +class Test {
> +  static RIGHT() {
> +    haha();
> +    haha2()
> +    let b = ChangeMe;
> +  }
> +}
> diff --git a/t/t4018/javascript-skip-keywords b/t/t4018/javascript-skip-keywords
> new file mode 100644
> index 0000000000..5584970b58
> --- /dev/null
> +++ b/t/t4018/javascript-skip-keywords
> @@ -0,0 +1,34 @@
> +function RIGHT(a, b) {
> +  import("./async1")
> +  if (a > 1) {
> +    // ...
> +  }
> +  do {
> +    // ...
> +  } while (i < 5);
> +  for (const element of array1) {
> +    console.log(element)
> +  }
> +  with(o) {
> +    console.log(x)
> +  }
> +  switch (expr) {
> +    case 'a':
> +      // ...
> +      break;
> +    case 'b':
> +      // ...
> +      break;
> +    default:
> +      // ...
> +  }
> +  try {
> +    // ...
> +    return (a + c)
> +  } 
> +  catch (error) {
> +    // ...
> +  }
> +
> +  return a + b; // ChangeMe
> +}
> diff --git a/t/t4018/javascript-static-function-in-class b/t/t4018/javascript-static-function-in-class
> new file mode 100644
> index 0000000000..fbf0b7ca3d
> --- /dev/null
> +++ b/t/t4018/javascript-static-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  static RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}

The rest of the test cases look good.
