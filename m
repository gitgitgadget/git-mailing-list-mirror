Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F57FBB5
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653264; cv=none; b=cPdUBgwReobAJCH1WnymuxmrNZFDKtFO8K6pz89Rh1yHUEXnn/D8ctucxzbHGYVxtSlJakuBHyeNFdAIF1Cz+ZHbhM79Vk9KrO0a7X6le5y8Dm2PrigxbnZxAm6+KBr8+2JkJetaLDCcFzqWK8KMAzU7SVtCe6XkJcdplobRH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653264; c=relaxed/simple;
	bh=Y7nsIKgbfotVosNKPGMXDBfrFjTPI6tZfLcGpa0mff8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n/YVt3Tkkn5K5tC3e57S9fxp2PHYpmtiHk5yqHmzgXLLEE44nHeRqLoFA+A6uxPt6xNEV/U7mNoz2OHGiSoA/lHqt0to0WhCJpiTuYQ1fyUBRe8uCo2lxxhR5bH57fnMfZB1QLVnJdqHKL6pdbIVGTFkIEfDNlvcEXQazUrqeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdALExsv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdALExsv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41494c040a1so8905515e9.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711653259; x=1712258059; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gu2rp2H95buOQjS+0rNC5PT1x36DKR+8YhxYzQ8XPQ=;
        b=UdALExsvUH1VA5WMzadXmkDNZYPDGOL1k1UKqGfe1KF8AYDlcOGQGjjjBSw96VT1mO
         Z5WPkNWHd1LTzPU8RgbbpR4yHA1o0vkKrN7YsX22XTCIgbLl11jG4jZ0jLTIZx1b5pOX
         w4DYffVILJepE5HpHK3sgEwS8xHwZHNpefobF4QE2kyqVqMoshGgWRWA2PaJ+Ma8+vzd
         kSPp/I9lj1TBZQr+J8H+ZRUPjsxlXh0QPxfl4c7A79lsNNvtGto4ALiQ0Nj1C0dG8tbG
         gVdCm6cIudJqMIxzmWsZxmNTpAwQL0HlZn1rdzZnecLagCkakZXUUnmSl56B/4wExV4J
         iyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653259; x=1712258059;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gu2rp2H95buOQjS+0rNC5PT1x36DKR+8YhxYzQ8XPQ=;
        b=NZ8RxgjObD9YCcx7rIGq3H6Zxmqbp2pVSBnQNMRhUgGULB/586HdvUH1fYpFqGhJgU
         a+PdRjFZ7aEHcOyB7Mlw9p+Y5y77n+O9vQRbx98bpx/C8OWKCuh2cQ0jQTVBHrpHILVZ
         b5BXRFoAR7T6C5JwNqcznmcrJ03KzjD15oE+t5fQaIyrpgSu+mMwsxzN4jKWJXpkKSrk
         1a5XETS2xiqq/fB8r9Zaj21iWIKFMHsMGtRGd7+wXM+fFiZjtGsmTSo2fcAFaMUI0AN3
         +pDxx0VwdgpJHdNFECLU3uqIlmUOafw1nKtlHoHAbw1MxKPv30dmSZ34TcAV7ao1ZVqx
         aKeQ==
X-Gm-Message-State: AOJu0YzUnmZynYQpgSqPyOIczy3uCtdNErrlAxWliKAo5pgho9xoP8fZ
	FEIPsH8swaLwJwkMuaRF+RYiJy20rX9pxsDYoNWG9MvPhUSlMA839APCXpwp
X-Google-Smtp-Source: AGHT+IEEd1jNFHe1TlQtZ0l98QWdWkeb77ZwcNo+3+rzVf8OKNqHzD5dWS3oY2rAUAxIVddRm7jx2A==
X-Received: by 2002:a05:600c:4710:b0:414:63da:a2a2 with SMTP id v16-20020a05600c471000b0041463daa2a2mr208180wmo.29.1711653259036;
        Thu, 28 Mar 2024 12:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0041492738677sm3126112wmo.11.2024.03.28.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:14:18 -0700 (PDT)
Message-Id: <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v3.git.git.1711613220277.gitgitgadget@gmail.com>
References: <pull.1682.v3.git.git.1711613220277.gitgitgadget@gmail.com>
From: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Mar 2024 19:14:16 +0000
Subject: [PATCH v4] userdiff: better method/property matching for C#
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jeff King <peff@peff.net>,
    Linus Arver <linusa@google.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Steven Jeuris <steven.jeuris@gmail.com>,
    Steven Jeuris <steven.jeuris@3shape.com>

From: Steven Jeuris <steven.jeuris@3shape.com>

- Support multi-line methods by not requiring closing parenthesis.
- Support multiple generics (comma was missing before).
- Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
- Remove `instanceof` keyword, which isn't C#.
- Also detect non-method keywords not positioned at the start of a line.
- Added tests; none existed before.

The overall strategy is to focus more on what isn't expected for
method/property definitions, instead of what is, but is fully optional.

Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
---
    userdiff: better method/property matching for C#
    
    Change since v1: I removed "from" from the list of keywords to skip.
    First, I considered adding "await", but I discovered both "await" and
    "from" are "contextual keywords", which unlike the other keywords
    currently listed, aren't reserved, and can thus cause false negatives.
    I.e., it is valid to have a method named "await" or "from". In edge
    cases, this may lead to false positives, but a different exclusion rule
    will need to be added to handle these.
    
    Change since v2:
    
     * Corrected comment formatting.
     * Added csharp-property-skip-body test.
     * Added comments in test code to explain sections not part of the test.
     * Elaborated regex comments.
     * Excluded math operators (+-*/%) in method pattern to not catch
       multiline operations, and tested for this in the -skip-body tests.
       Catching "-" only worked when it was defined at the end of the
       exclusion block for some reason. The regex matcher seems quite
       bugged.
    
    Change since v3:
    
     * Changed regex to better handle whitespace in types, making use of the
       fact that it only appears after commas.
     * Split regex into multiple lines with comments explaining structure.
     * Split the "skip body" tests into more narrow csharp-exclude- tests.
     * Added a test for generic methods:
       csharp-exclude-generic-method-calls.
     * Added a test for array types used in methods: csharp-method-array.
     * Added an addition property test: csharp-property-braces-same-line.
     * Included a test for "( func(x)" case identified by Johannes in
       csharp-exclude-assignments.
    
    As before, I ran into many regex limitations (no possessive quantifiers,
    no lookahead). It also seems different regex evaluators are used on
    different test runs. Which one does git diff use? Maybe it is about time
    to update this? E.g., if speed is a concern, possessive quantifiers can
    speed up search.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1682%2FWhathecode%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1682/Whathecode/master-v4
Pull-Request: https://github.com/git/git/pull/1682

Range-diff vs v3:

 1:  9b6c76f5342 ! 1:  2feb84beaa0 userdiff: better method/property matching for C#
     @@ Commit message
      
          Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
      
     - ## t/t4018/csharp-method (new) ##
     + ## t/t4018/csharp-exclude-assignments (new) ##
      @@
      +class Example
      +{
      +    string Method(int RIGHT)
      +    {
     -+        // Filler
     -+        // Filler
     ++        var constantAssignment = "test";
     ++        var methodAssignment = MethodCall();
     ++        var multiLineMethodAssignment = MethodCall(
     ++        );
     ++        var multiLine = "first"
     ++            + MethodCall()
     ++            +
     ++            ( MethodCall()
     ++            )
     ++            + MethodCall();
      +
      +        return "ChangeMe";
      +    }
     -+}
     -
     - ## t/t4018/csharp-method-explicit (new) ##
     -@@
     -+using System;
      +
     -+class Example : IDisposable
     -+{
     -+    void IDisposable.Dispose() // RIGHT
     -+    {
     -+        // Filler
     -+        // Filler
     -+        
     -+        // ChangeMe
     -+    }
     -+}
     -
     - ## t/t4018/csharp-method-generics (new) ##
     -@@
     -+class Example<T1, T2>
     -+{
     -+    Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
     -+    {
     -+        // Filler
     -+        // Filler
     -+        
     -+        // ChangeMe
     -+        return null;
     -+    }
     ++    string MethodCall(int a = 0, int b = 0) => "test";
      +}
      
     - ## t/t4018/csharp-method-modifiers (new) ##
     + ## t/t4018/csharp-exclude-control-statements (new) ##
      @@
     -+using System.Threading.Tasks;
     -+
      +class Example
      +{
     -+    static internal async Task Method(int RIGHT)
     ++    string Method(int RIGHT)
      +    {
     -+        // Filler
     -+        // Filler
     -+        
     -+        // ChangeMe
     -+        await Task.Delay(1);
     ++        if (false)
     ++        {
     ++            return "out";
     ++        }
     ++        else { }
     ++        if (true) MethodCall(
     ++        );
     ++        else MethodCall(
     ++        );
     ++        switch ("test")
     ++        {
     ++            case "one":
     ++            return MethodCall(
     ++            );
     ++            case "two":
     ++            break;
     ++        }
     ++        (int, int) tuple = (1, 4);
     ++        switch (tuple)
     ++        {
     ++            case (1, 4):
     ++              MethodCall();
     ++		      break;
     ++        }
     ++
     ++        return "ChangeMe";
      +    }
     ++
     ++    string MethodCall(int a = 0, int b = 0) => "test";
      +}
      
     - ## t/t4018/csharp-method-multiline (new) ##
     + ## t/t4018/csharp-exclude-exceptions (new) ##
      @@
     ++using System;
     ++
      +class Example
      +{
     -+    string Method_RIGHT(
     -+        int a,
     -+        int b,
     -+        int c)
     ++    string Method(int RIGHT)
      +    {
     ++        try
     ++        {
     ++            throw new Exception("fail");
     ++        }
     ++        catch (Exception)
     ++        {
     ++        }
     ++        finally
     ++        {
     ++        }
     ++        try { } catch (Exception) {}
     ++        try
     ++        {
     ++            throw GetException(
     ++            );
     ++        }
     ++        catch (Exception) { }
     ++
      +        return "ChangeMe";
      +    }
     ++
     ++    Exception GetException() => new Exception("fail");
      +}
      
     - ## t/t4018/csharp-method-params (new) ##
     + ## t/t4018/csharp-exclude-generic-method-calls (new) ##
      @@
      +class Example
      +{
     -+    string Method(int RIGHT, int b, int c = 42)
     ++    string Method(int RIGHT)
      +    {
     -+        // Filler
     -+        // Filler
     -+        
     ++        GenericMethodCall<int, int>(
     ++            );
     ++
      +        return "ChangeMe";
      +    }
     ++
     ++    string GenericMethodCall<T, T2>() => "test";
      +}
      
     - ## t/t4018/csharp-method-skip-body (new) ##
     + ## t/t4018/csharp-exclude-init-dispose (new) ##
      @@
     -+using System.Linq;
      +using System;
      +
      +class Example : IDisposable
      +{
      +    string Method(int RIGHT)
      +    {
     -+        // Method calls
     -+        MethodCall();
     -+        MethodCall(1, 2);
     -+        MethodCall(
     -+            1, 2);
     -+
     -+        // Assignments
     -+        var constantAssignment = "test";
     -+        var methodAssignment = MethodCall();
     -+        var multiLineMethodAssignment = MethodCall(
     -+        );
     -+        var multiLine = "first"
     -+            + MethodCall()
     -+            - MethodCall()
     -+            + MethodCall();
     -+
     -+        // Initializations/disposal
      +        new Example();
      +        new Example(
      +            );
     @@ t/t4018/csharp-method-skip-body (new)
      +            this is default(
      +                Example);
      +
     -+        // Iteration statements
     ++        return "ChangeMe";
     ++    }
     ++
     ++    public void Dispose() {}
     ++}
     +
     + ## t/t4018/csharp-exclude-iterations (new) ##
     +@@
     ++using System.Linq;
     ++
     ++class Example
     ++{
     ++    string Method(int RIGHT)
     ++    {
      +        do { } while (true);
      +        do MethodCall(
      +        ); while (true);
     @@ t/t4018/csharp-method-skip-body (new)
      +        }
      +        int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
      +
     -+        // Control
     -+        if (false)
     -+        {
     -+            return "out";
     -+        }
     -+        else { }
     -+        if (true) MethodCall(
     -+        );
     -+        else MethodCall(
     -+        );
     -+        switch ("test")
     -+        {
     -+            case "one":
     -+            return MethodCall(
     -+            );
     -+            case "two":
     -+            break;
     -+        }
     -+        (int, int) tuple = (1, 4);
     -+        switch (tuple)
     -+        {
     -+            case (1, 4):
     -+            MethodCall();
     -+        }
     ++        return "ChangeMe";
     ++    }
      +
     -+        // Exceptions
     -+        try
     -+        {
     -+            throw new Exception("fail");
     -+        }
     -+        catch (Exception)
     -+        {
     -+        }
     -+        finally
     -+        {
     -+        }
     -+        try { } catch (Exception) {}
     -+        try
     -+        {
     -+            throw GetException(
     -+            );
     -+        }
     -+        catch (Exception) { }
     ++    string MethodCall(int a = 0, int b = 0) => "test";
     ++}
     +
     + ## t/t4018/csharp-exclude-method-calls (new) ##
     +@@
     ++class Example
     ++{
     ++    string Method(int RIGHT)
     ++    {
     ++        MethodCall();
     ++        MethodCall(1, 2);
     ++        MethodCall(
     ++            1, 2);
      +
     -+        // Others
     ++        return "ChangeMe";
     ++    }
     ++
     ++    string MethodCall(int a = 0, int b = 0) => "test";
     ++    string GenericMethodCall<T, T2>() => "test";
     ++}
     +
     + ## t/t4018/csharp-exclude-other (new) ##
     +@@
     ++class Example
     ++{
     ++    string Method(int RIGHT)
     ++    {
      +        lock (this)
      +        {
      +        }
     @@ t/t4018/csharp-method-skip-body (new)
      +
      +        return "ChangeMe";
      +    }
     ++}
     +
     + ## t/t4018/csharp-method (new) ##
     +@@
     ++class Example
     ++{
     ++    string Method(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
      +
     -+    // Supporting methods to make the tested method above valid C#.
     -+    public void Dispose() {}
     -+    string MethodCall(int a = 0, int b = 0) => "test";
     -+    Exception GetException() => new Exception("fail");
     -+    int[] Numbers() => [0, 1];
     ++        return "ChangeMe";
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-array (new) ##
     +@@
     ++class Example
     ++{
     ++    string[] Method(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
     ++
     ++        return ["ChangeMe"];
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-explicit (new) ##
     +@@
     ++using System;
     ++
     ++class Example : IDisposable
     ++{
     ++    void IDisposable.Dispose() // RIGHT
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-generics (new) ##
     +@@
     ++class Example<T1, T2>
     ++{
     ++    Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++        return null;
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-modifiers (new) ##
     +@@
     ++using System.Threading.Tasks;
     ++
     ++class Example
     ++{
     ++    static internal async Task Method(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++        await Task.Delay(1);
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-multiline (new) ##
     +@@
     ++class Example
     ++{
     ++    string Method_RIGHT(
     ++        int a,
     ++        int b,
     ++        int c)
     ++    {
     ++        return "ChangeMe";
     ++    }
     ++}
     +
     + ## t/t4018/csharp-method-params (new) ##
     +@@
     ++class Example
     ++{
     ++    string Method(int RIGHT, int b, int c = 42)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        return "ChangeMe";
     ++    }
      +}
      
       ## t/t4018/csharp-method-special-chars (new) ##
     @@ t/t4018/csharp-method-with-spacing (new)
      @@
      +class Example
      +{
     -+		string   Method 	( int 	RIGHT )
     -+	{
     ++    	string   Method 	( int 	RIGHT )
     ++    {
      +        // Filler
      +        // Filler
     -+		
     ++
      +        return "ChangeMe";
      +    }
      +}
     @@ t/t4018/csharp-property (new)
      +    }
      +}
      
     - ## t/t4018/csharp-property-skip-body (new) ##
     + ## t/t4018/csharp-property-braces-same-line (new) ##
      @@
     -+using System.Linq;
     -+using System;
     -+
     -+class Example : IDisposable
     ++class Example
      +{
     -+    public string RIGHT
     -+    {
     -+        get
     ++    public bool RIGHT {
     ++        get { return true; }
     ++        set
      +        {
     -+            // Method calls
     -+            MethodCall();
     -+            MethodCall(1, 2);
     -+            MethodCall(
     -+                1, 2);
     -+
     -+            // Assignments
     -+            var constantAssignment = "test";
     -+            var methodAssignment = MethodCall();
     -+            var multiLineMethodAssignment = MethodCall(
     -+                );
     -+            var multiLine = "first"
     -+                + MethodCall()
     -+                - MethodCall()
     -+                + MethodCall();
     -+
     -+            // Initializations/disposal
     -+            new Example();
     -+            new Example(
     -+                );
     -+            new Example { };
     -+            using (this)
     -+            {
     -+            }
     -+            var def =
     -+                this is default(
     -+                    Example);
     -+
     -+            // Iteration statements
     -+            do { } while (true);
     -+            do MethodCall(
     -+            ); while (true);
     -+            while (true);
     -+            while (true) {
     -+                break;
     -+            }
     -+            for (int i = 0; i < 10; ++i)
     -+            {
     -+            }
     -+            foreach (int i in Enumerable.Range(0, 10))
     -+            {
     -+            }
     -+            int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
     -+
     -+            // Control
     -+            if (false)
     -+            {
     -+                return "out";
     -+            }
     -+            else { }
     -+            if (true) MethodCall(
     -+            );
     -+            else MethodCall(
     -+            );
     -+            switch ("test")
     -+            {
     -+                case "one":
     -+                return MethodCall(
     -+                );
     -+                case "two":
     -+                break;
     -+            }
     -+            (int, int) tuple = (1, 4);
     -+            switch (tuple)
     -+            {
     -+                case (1, 4):
     -+                MethodCall();
     -+            }
     -+
     -+            // Exceptions
     -+            try
     -+            {
     -+                throw new Exception("fail");
     -+            }
     -+            catch (Exception)
     -+            {
     -+            }
     -+            finally
     -+            {
     -+            }
     -+            try { } catch (Exception) {}
     -+            try
     -+            {
     -+                throw GetException(
     -+                );
     -+            }
     -+            catch (Exception) { }
     -+
     -+            // Others
     -+            lock (this)
     -+            {
     -+            }
     -+            unsafe
     -+            {
     -+                byte[] bytes = [1, 2, 3];
     -+                fixed (byte* pointerToFirst = bytes)
     -+                {
     -+                }
     -+            }
     -+
     -+            return "ChangeMe";
     ++            // ChangeMe
      +        }
     -+        set { }
      +    }
     -+
     -+    // Supporting methods to make the tested property above valid C#.
     -+    public void Dispose() {}
     -+    string MethodCall(int a = 0, int b = 0) => "test";
     -+    Exception GetException() => new Exception("fail");
     -+    int[] Numbers() => [0, 1];
      +}
      
       ## userdiff.c ##
     @@ userdiff.c: PATTERNS("cpp",
      +	  * can be followed by parentheses without special characters in between,
      +	  * making them look like methods.
      +	  */
     -+	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
     ++	 "!(^|[ \t]+)" /* Start of line or whitespace. */
     ++		"(do|while|for|foreach|if|else|new|default|return|switch|case|throw"
     ++		"|catch|using|lock|fixed)"
     ++		"([ \t(]+|$)\n" /* Whitespace, "(", or end of line. */
      +	 /*
      +	  * Methods/constructors:
      +	  * The strategy is to identify a minimum of two groups (any combination
     -+	  * of keywords/type/name), without intermediate characters which can't be
     -+	  * part of method definitions before the opening parenthesis, and without
     ++	  * of keywords/type/name) before the opening parenthesis, and without
      +	  * final unexpected characters, normally only used in ordinary statements.
     -+	  * "=" is excluded to ignore assignments, but as a result rules out
     -+	  * methods with expression bodies. However, since those fit on 1-2 lines,
     -+	  * a chunk header isn't useful either way.
      +	  */
     -+	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t+*%\\/\\-][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
     ++	 "^[ \t]*" /* Remove leading whitespace. */
     ++		"(" /* Start chunk header capture. */
     ++		"(" /* Group of keywords/type/names. */
     ++		"([][[:alnum:]@_<>.]|, [ |\t]*)+" /* Space only allowed after ",". */
     ++		"[ \t]+" /* One required space forces a minimum of two items. */
     ++		"([][[:alnum:]@_<>.]|, [ |\t]*)+"
     ++		"[ \t]*" /* Optional space before parameters start. */
     ++		")+"
     ++		"\\(" /* Start of method parameters. */
     ++		"[^;]*" /* Allow complex parameters, but exclude statements (;). */
     ++		")$\n" /* Close chunk header capture. */
      +	 /*
      +	  * Properties:
     -+	  * As with methods, expect a minimum of two groups. And, the vast majority
     -+	  * of properties long enough to be worth showing a chunk header for don't
     -+	  * include "=:;,()" on the line they are defined.
     ++	  * As with methods, expect a minimum of two groups. But, more trivial than
     ++	  * methods, the vast majority of properties long enough to be worth
     ++	  * showing a chunk header for don't include "=:;,()" on the line they are
     ++	  * defined, since they don't have a parameter list.
      +	  */
     -+	 "^[ \t]*([][[:alnum:]@_<>.,]+[ \t]+[][[:alnum:]@_.]+[^=:;,()]*)$\n"
     ++	 "^[ \t]*("
     ++		"("
     ++		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]+"
     ++		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]*"
     ++		")+" /* Up to here, same as methods regex. */
     ++		"[^;=:,()]*" /* Compared to methods, no parameter list allowed. */
     ++		")$\n"
       	 /* Type definitions */
       	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
       	 /* Namespace */


 t/t4018/csharp-exclude-assignments          | 20 +++++++++
 t/t4018/csharp-exclude-control-statements   | 34 +++++++++++++++
 t/t4018/csharp-exclude-exceptions           | 29 +++++++++++++
 t/t4018/csharp-exclude-generic-method-calls | 12 ++++++
 t/t4018/csharp-exclude-init-dispose         | 22 ++++++++++
 t/t4018/csharp-exclude-iterations           | 26 ++++++++++++
 t/t4018/csharp-exclude-method-calls         | 15 +++++++
 t/t4018/csharp-exclude-other                | 18 ++++++++
 t/t4018/csharp-method                       | 10 +++++
 t/t4018/csharp-method-array                 | 10 +++++
 t/t4018/csharp-method-explicit              | 12 ++++++
 t/t4018/csharp-method-generics              | 11 +++++
 t/t4018/csharp-method-modifiers             | 13 ++++++
 t/t4018/csharp-method-multiline             | 10 +++++
 t/t4018/csharp-method-params                | 10 +++++
 t/t4018/csharp-method-special-chars         | 11 +++++
 t/t4018/csharp-method-with-spacing          | 10 +++++
 t/t4018/csharp-property                     | 11 +++++
 t/t4018/csharp-property-braces-same-line    | 10 +++++
 userdiff.c                                  | 46 ++++++++++++++++++---
 20 files changed, 334 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/csharp-exclude-assignments
 create mode 100644 t/t4018/csharp-exclude-control-statements
 create mode 100644 t/t4018/csharp-exclude-exceptions
 create mode 100644 t/t4018/csharp-exclude-generic-method-calls
 create mode 100644 t/t4018/csharp-exclude-init-dispose
 create mode 100644 t/t4018/csharp-exclude-iterations
 create mode 100644 t/t4018/csharp-exclude-method-calls
 create mode 100644 t/t4018/csharp-exclude-other
 create mode 100644 t/t4018/csharp-method
 create mode 100644 t/t4018/csharp-method-array
 create mode 100644 t/t4018/csharp-method-explicit
 create mode 100644 t/t4018/csharp-method-generics
 create mode 100644 t/t4018/csharp-method-modifiers
 create mode 100644 t/t4018/csharp-method-multiline
 create mode 100644 t/t4018/csharp-method-params
 create mode 100644 t/t4018/csharp-method-special-chars
 create mode 100644 t/t4018/csharp-method-with-spacing
 create mode 100644 t/t4018/csharp-property
 create mode 100644 t/t4018/csharp-property-braces-same-line

diff --git a/t/t4018/csharp-exclude-assignments b/t/t4018/csharp-exclude-assignments
new file mode 100644
index 00000000000..239f312963b
--- /dev/null
+++ b/t/t4018/csharp-exclude-assignments
@@ -0,0 +1,20 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        var constantAssignment = "test";
+        var methodAssignment = MethodCall();
+        var multiLineMethodAssignment = MethodCall(
+        );
+        var multiLine = "first"
+            + MethodCall()
+            +
+            ( MethodCall()
+            )
+            + MethodCall();
+
+        return "ChangeMe";
+    }
+
+    string MethodCall(int a = 0, int b = 0) => "test";
+}
diff --git a/t/t4018/csharp-exclude-control-statements b/t/t4018/csharp-exclude-control-statements
new file mode 100644
index 00000000000..3a0f404ee10
--- /dev/null
+++ b/t/t4018/csharp-exclude-control-statements
@@ -0,0 +1,34 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        if (false)
+        {
+            return "out";
+        }
+        else { }
+        if (true) MethodCall(
+        );
+        else MethodCall(
+        );
+        switch ("test")
+        {
+            case "one":
+            return MethodCall(
+            );
+            case "two":
+            break;
+        }
+        (int, int) tuple = (1, 4);
+        switch (tuple)
+        {
+            case (1, 4):
+              MethodCall();
+		      break;
+        }
+
+        return "ChangeMe";
+    }
+
+    string MethodCall(int a = 0, int b = 0) => "test";
+}
diff --git a/t/t4018/csharp-exclude-exceptions b/t/t4018/csharp-exclude-exceptions
new file mode 100644
index 00000000000..b1e64256cfe
--- /dev/null
+++ b/t/t4018/csharp-exclude-exceptions
@@ -0,0 +1,29 @@
+using System;
+
+class Example
+{
+    string Method(int RIGHT)
+    {
+        try
+        {
+            throw new Exception("fail");
+        }
+        catch (Exception)
+        {
+        }
+        finally
+        {
+        }
+        try { } catch (Exception) {}
+        try
+        {
+            throw GetException(
+            );
+        }
+        catch (Exception) { }
+
+        return "ChangeMe";
+    }
+
+    Exception GetException() => new Exception("fail");
+}
diff --git a/t/t4018/csharp-exclude-generic-method-calls b/t/t4018/csharp-exclude-generic-method-calls
new file mode 100644
index 00000000000..31af546665d
--- /dev/null
+++ b/t/t4018/csharp-exclude-generic-method-calls
@@ -0,0 +1,12 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        GenericMethodCall<int, int>(
+            );
+
+        return "ChangeMe";
+    }
+
+    string GenericMethodCall<T, T2>() => "test";
+}
diff --git a/t/t4018/csharp-exclude-init-dispose b/t/t4018/csharp-exclude-init-dispose
new file mode 100644
index 00000000000..2bc8e194e20
--- /dev/null
+++ b/t/t4018/csharp-exclude-init-dispose
@@ -0,0 +1,22 @@
+using System;
+
+class Example : IDisposable
+{
+    string Method(int RIGHT)
+    {
+        new Example();
+        new Example(
+            );
+        new Example { };
+        using (this)
+        {
+        }
+        var def =
+            this is default(
+                Example);
+
+        return "ChangeMe";
+    }
+
+    public void Dispose() {}
+}
diff --git a/t/t4018/csharp-exclude-iterations b/t/t4018/csharp-exclude-iterations
new file mode 100644
index 00000000000..960aa182ae2
--- /dev/null
+++ b/t/t4018/csharp-exclude-iterations
@@ -0,0 +1,26 @@
+using System.Linq;
+
+class Example
+{
+    string Method(int RIGHT)
+    {
+        do { } while (true);
+        do MethodCall(
+        ); while (true);
+        while (true);
+        while (true) {
+            break;
+        }
+        for (int i = 0; i < 10; ++i)
+        {
+        }
+        foreach (int i in Enumerable.Range(0, 10))
+        {
+        }
+        int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
+
+        return "ChangeMe";
+    }
+
+    string MethodCall(int a = 0, int b = 0) => "test";
+}
diff --git a/t/t4018/csharp-exclude-method-calls b/t/t4018/csharp-exclude-method-calls
new file mode 100644
index 00000000000..8afe2a54638
--- /dev/null
+++ b/t/t4018/csharp-exclude-method-calls
@@ -0,0 +1,15 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        MethodCall();
+        MethodCall(1, 2);
+        MethodCall(
+            1, 2);
+
+        return "ChangeMe";
+    }
+
+    string MethodCall(int a = 0, int b = 0) => "test";
+    string GenericMethodCall<T, T2>() => "test";
+}
diff --git a/t/t4018/csharp-exclude-other b/t/t4018/csharp-exclude-other
new file mode 100644
index 00000000000..4d5581cf3e1
--- /dev/null
+++ b/t/t4018/csharp-exclude-other
@@ -0,0 +1,18 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        lock (this)
+        {
+        }
+        unsafe
+        {
+            byte[] bytes = [1, 2, 3];
+            fixed (byte* pointerToFirst = bytes)
+            {
+            }
+        }
+
+        return "ChangeMe";
+    }
+}
diff --git a/t/t4018/csharp-method b/t/t4018/csharp-method
new file mode 100644
index 00000000000..16b367aca2b
--- /dev/null
+++ b/t/t4018/csharp-method
@@ -0,0 +1,10 @@
+class Example
+{
+    string Method(int RIGHT)
+    {
+        // Filler
+        // Filler
+
+        return "ChangeMe";
+    }
+}
diff --git a/t/t4018/csharp-method-array b/t/t4018/csharp-method-array
new file mode 100644
index 00000000000..1126de8201d
--- /dev/null
+++ b/t/t4018/csharp-method-array
@@ -0,0 +1,10 @@
+class Example
+{
+    string[] Method(int RIGHT)
+    {
+        // Filler
+        // Filler
+
+        return ["ChangeMe"];
+    }
+}
diff --git a/t/t4018/csharp-method-explicit b/t/t4018/csharp-method-explicit
new file mode 100644
index 00000000000..5a710116cc4
--- /dev/null
+++ b/t/t4018/csharp-method-explicit
@@ -0,0 +1,12 @@
+using System;
+
+class Example : IDisposable
+{
+    void IDisposable.Dispose() // RIGHT
+    {
+        // Filler
+        // Filler
+        
+        // ChangeMe
+    }
+}
diff --git a/t/t4018/csharp-method-generics b/t/t4018/csharp-method-generics
new file mode 100644
index 00000000000..b3216bfb2a7
--- /dev/null
+++ b/t/t4018/csharp-method-generics
@@ -0,0 +1,11 @@
+class Example<T1, T2>
+{
+    Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
+    {
+        // Filler
+        // Filler
+        
+        // ChangeMe
+        return null;
+    }
+}
diff --git a/t/t4018/csharp-method-modifiers b/t/t4018/csharp-method-modifiers
new file mode 100644
index 00000000000..caefa8ee99c
--- /dev/null
+++ b/t/t4018/csharp-method-modifiers
@@ -0,0 +1,13 @@
+using System.Threading.Tasks;
+
+class Example
+{
+    static internal async Task Method(int RIGHT)
+    {
+        // Filler
+        // Filler
+        
+        // ChangeMe
+        await Task.Delay(1);
+    }
+}
diff --git a/t/t4018/csharp-method-multiline b/t/t4018/csharp-method-multiline
new file mode 100644
index 00000000000..3983ff42f51
--- /dev/null
+++ b/t/t4018/csharp-method-multiline
@@ -0,0 +1,10 @@
+class Example
+{
+    string Method_RIGHT(
+        int a,
+        int b,
+        int c)
+    {
+        return "ChangeMe";
+    }
+}
diff --git a/t/t4018/csharp-method-params b/t/t4018/csharp-method-params
new file mode 100644
index 00000000000..3f00410ba1f
--- /dev/null
+++ b/t/t4018/csharp-method-params
@@ -0,0 +1,10 @@
+class Example
+{
+    string Method(int RIGHT, int b, int c = 42)
+    {
+        // Filler
+        // Filler
+        
+        return "ChangeMe";
+    }
+}
diff --git a/t/t4018/csharp-method-special-chars b/t/t4018/csharp-method-special-chars
new file mode 100644
index 00000000000..e6c7bc01a18
--- /dev/null
+++ b/t/t4018/csharp-method-special-chars
@@ -0,0 +1,11 @@
+class @Some_Type
+{
+    @Some_Type @Method_With_Underscore(int RIGHT)
+    {
+        // Filler
+        // Filler
+        
+        // ChangeMe
+        return new @Some_Type();
+    }
+}
diff --git a/t/t4018/csharp-method-with-spacing b/t/t4018/csharp-method-with-spacing
new file mode 100644
index 00000000000..233bb976cc2
--- /dev/null
+++ b/t/t4018/csharp-method-with-spacing
@@ -0,0 +1,10 @@
+class Example
+{
+    	string   Method 	( int 	RIGHT )
+    {
+        // Filler
+        // Filler
+
+        return "ChangeMe";
+    }
+}
diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
new file mode 100644
index 00000000000..e56dfce34c1
--- /dev/null
+++ b/t/t4018/csharp-property
@@ -0,0 +1,11 @@
+class Example
+{
+    public bool RIGHT
+    {
+        get { return true; }
+        set
+        {
+            // ChangeMe
+        }
+    }
+}
diff --git a/t/t4018/csharp-property-braces-same-line b/t/t4018/csharp-property-braces-same-line
new file mode 100644
index 00000000000..608131d3d31
--- /dev/null
+++ b/t/t4018/csharp-property-braces-same-line
@@ -0,0 +1,10 @@
+class Example
+{
+    public bool RIGHT {
+        get { return true; }
+        set
+        {
+            // ChangeMe
+        }
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index e399543823b..35e0e1183f7 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -89,12 +89,46 @@ PATTERNS("cpp",
 	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
-	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 /*
+	  * Jump over reserved keywords which are illegal method names, but which
+	  * can be followed by parentheses without special characters in between,
+	  * making them look like methods.
+	  */
+	 "!(^|[ \t]+)" /* Start of line or whitespace. */
+		"(do|while|for|foreach|if|else|new|default|return|switch|case|throw"
+		"|catch|using|lock|fixed)"
+		"([ \t(]+|$)\n" /* Whitespace, "(", or end of line. */
+	 /*
+	  * Methods/constructors:
+	  * The strategy is to identify a minimum of two groups (any combination
+	  * of keywords/type/name) before the opening parenthesis, and without
+	  * final unexpected characters, normally only used in ordinary statements.
+	  */
+	 "^[ \t]*" /* Remove leading whitespace. */
+		"(" /* Start chunk header capture. */
+		"(" /* Group of keywords/type/names. */
+		"([][[:alnum:]@_<>.]|, [ |\t]*)+" /* Space only allowed after ",". */
+		"[ \t]+" /* One required space forces a minimum of two items. */
+		"([][[:alnum:]@_<>.]|, [ |\t]*)+"
+		"[ \t]*" /* Optional space before parameters start. */
+		")+"
+		"\\(" /* Start of method parameters. */
+		"[^;]*" /* Allow complex parameters, but exclude statements (;). */
+		")$\n" /* Close chunk header capture. */
+	 /*
+	  * Properties:
+	  * As with methods, expect a minimum of two groups. But, more trivial than
+	  * methods, the vast majority of properties long enough to be worth
+	  * showing a chunk header for don't include "=:;,()" on the line they are
+	  * defined, since they don't have a parameter list.
+	  */
+	 "^[ \t]*("
+		"("
+		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]+"
+		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]*"
+		")+" /* Up to here, same as methods regex. */
+		"[^;=:,()]*" /* Compared to methods, no parameter list allowed. */
+		")$\n"
 	 /* Type definitions */
 	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
 	 /* Namespace */

base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
-- 
gitgitgadget
