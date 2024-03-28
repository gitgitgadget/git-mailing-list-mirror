Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA42C1A0
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613228; cv=none; b=cBxYYtOhFiOzYTJoikqHZTL3FHYvver6I5wJ6s/1lTshT5eOWgvABZu/AC9a2PWpx43Q4enYQ8ab3IzcfoEaAk0ELkr0TbKWUggIhvOK7CMqFAthZPoQqyPxa1BNsIMUHIaXEhdxcbwIfs+Qx9xnOCi9ZVxzp+dOPYau8K9FZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613228; c=relaxed/simple;
	bh=9AEOUAwPwV8TCiKHjkm9v8RVYowm7m8hMBVNxTnlE7Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AsjuynY29t9CXk20RQUdih5whHh3IaZLuqaJ4d8C9t/7Y0EKXeyOsNdQaBQoUW0dssczMhA94DDbCgK6WAvDl2n+ECxgd5w1gigfp96uQaGuxKOtvtft/3b0Xyosk6nz7NgQjkzuweuSKqu6xdvk61T4oUn5sicc+Xa2fD1VUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coArk44H; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coArk44H"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so8201021fa.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711613223; x=1712218023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seZ7kyh8O5O/1tO3r4nYMN2iuyZ0FLmTWzkM6g2of04=;
        b=coArk44HnKSqbWDbyUOpbgjAaxNsUNXoT0L9bq/xdgyeIFXGZnaz06a/djrqwG9LgE
         9+/qspngRsMzr94p1zH1h61mwKAjVuiBW6ypcOlje7oicdIoxh0PjawGqJNy24pIbtaB
         1rX/NdoqBLgIiomSqR3IRjGhgmadppu+DTgUB3naPlGaMXk+I8np1dVajnitgPTAemeg
         lggczZ+UQj6LMMuKIm0NSQ8wHfPQg+/uwJA6xVROfzsMVL147kUDeMXNXq5/D3sndviU
         qo++oVX65Jh0UuX/5xrinjxo2lIays2vguWAvq4um/b5YszwDCk3kDDwQsetaVA2y9s7
         SHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613223; x=1712218023;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seZ7kyh8O5O/1tO3r4nYMN2iuyZ0FLmTWzkM6g2of04=;
        b=uX8XCamJ3qnnNSp9uWKsTszR4L6yiMn862tYIaho16/a3SD3BEAYvpBJQKieR62J5f
         8jHUxuiGscPygHJFjN3bNVasIYWxLzHXcCZ+h37MVXbOu8YLDbyT88xuuHlG3QToyQ1/
         qVV7TEk/dVZlyKDNADbUJy/wI9e1r99OcYVlL8AUe5+XNV0J+OPujKQ9scfy/hNHgngP
         OFH6TmCJuuz/fsbLr2ppFCdzmllBToLMR0es52oi0eKLJ2unkIyofljyviBsMWIDgGEU
         gEuec7J66ijqtfmcF/NNijAlxbS6YSERXQ5yY5dmd8wUjZuwfPlJW7RCiYryohdDGc57
         ylSw==
X-Gm-Message-State: AOJu0YzrZeKAJrsCby4rahqiTLVtRzHzTXvJtLdTSM+yshqDpMg7cjUL
	VEZSzLhHke3QumLgLSFBRJq2kOTrqvtuku7/JJoOTrmK6QR6HwMJub1+nP/k
X-Google-Smtp-Source: AGHT+IGhuX0k0us1nli7znMUCUFuu6qegpZxyGDgC0MYaVXcH5Br8ixnKDARR950QFjOxdecx457jg==
X-Received: by 2002:a2e:8612:0:b0:2d6:a5cf:367c with SMTP id a18-20020a2e8612000000b002d6a5cf367cmr1649899lji.38.1711613222775;
        Thu, 28 Mar 2024 01:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b004140c161e8dsm4635202wmq.43.2024.03.28.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 01:07:01 -0700 (PDT)
Message-Id: <pull.1682.v3.git.git.1711613220277.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
References: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
From: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Mar 2024 08:07:00 +0000
Subject: [PATCH v3] userdiff: better method/property matching for C#
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1682%2FWhathecode%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1682/Whathecode/master-v3
Pull-Request: https://github.com/git/git/pull/1682

Range-diff vs v2:

 1:  00315519014 ! 1:  9b6c76f5342 userdiff: better method/property matching for C#
     @@ t/t4018/csharp-method (new)
      @@
      +class Example
      +{
     -+	string Method(int RIGHT)
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		return "ChangeMe";
     -+	}
     ++    string Method(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
     ++
     ++        return "ChangeMe";
     ++    }
      +}
      
       ## t/t4018/csharp-method-explicit (new) ##
     @@ t/t4018/csharp-method-explicit (new)
      +
      +class Example : IDisposable
      +{
     -+	void IDisposable.Dispose() // RIGHT
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		// ChangeMe
     -+	}
     ++    void IDisposable.Dispose() // RIGHT
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++    }
      +}
      
       ## t/t4018/csharp-method-generics (new) ##
      @@
      +class Example<T1, T2>
      +{
     -+	Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		// ChangeMe
     -+		return null;
     -+	}
     ++    Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++        return null;
     ++    }
      +}
      
       ## t/t4018/csharp-method-modifiers (new) ##
     @@ t/t4018/csharp-method-modifiers (new)
      +
      +class Example
      +{
     -+	static internal async Task Method(int RIGHT)
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		// ChangeMe
     -+		await Task.Delay(1);
     -+	}
     ++    static internal async Task Method(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++        await Task.Delay(1);
     ++    }
      +}
      
       ## t/t4018/csharp-method-multiline (new) ##
      @@
      +class Example
      +{
     -+	string Method_RIGHT(
     -+		int a,
     -+		int b,
     -+		int c)
     -+	{
     -+		return "ChangeMe";
     -+	}
     ++    string Method_RIGHT(
     ++        int a,
     ++        int b,
     ++        int c)
     ++    {
     ++        return "ChangeMe";
     ++    }
      +}
      
       ## t/t4018/csharp-method-params (new) ##
      @@
      +class Example
      +{
     -+	string Method(int RIGHT, int b, int c = 42)
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		return "ChangeMe";
     -+	}
     ++    string Method(int RIGHT, int b, int c = 42)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        return "ChangeMe";
     ++    }
      +}
      
       ## t/t4018/csharp-method-skip-body (new) ##
     @@ t/t4018/csharp-method-skip-body (new)
      +
      +class Example : IDisposable
      +{
     -+	string Method(int RIGHT)
     -+	{
     -+		// Method calls
     -+		MethodCall();
     -+		MethodCall(1, 2);
     -+		MethodCall(
     -+			1, 2);
     -+		
     -+		// Assignments
     -+		var constantAssignment = "test";
     -+		var methodAssignment = MethodCall();
     -+		var multiLineMethodAssignment = MethodCall(
     -+			);
     -+		
     -+		// Initializations/disposal
     -+		new Example();
     -+		new Example(
     -+			);
     -+		new Example { };
     -+		using (this) 
     -+		{
     -+		}
     -+		var def =
     -+			this is default(
     -+				Example);
     -+		
     -+		// Iteration statements
     -+		do { } while (true);
     -+		do MethodCall(
     -+			); while (true);
     -+		while (true);
     -+		while (true) {
     -+			break;
     -+		}
     -+		for (int i = 0; i < 10; ++i)
     -+		{
     -+		}
     -+		foreach (int i in Enumerable.Range(0, 10))
     -+		{
     -+		}
     -+		int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
     -+		
     -+		// Control
     -+		if (false)
     -+		{
     -+			return "out";
     -+		}
     -+		else { }
     -+		if (true) MethodCall(
     -+			);
     -+		else MethodCall(
     -+			);
     -+		switch ("test")
     -+		{
     -+			case "one":
     -+				return MethodCall(
     -+					);
     -+			case "two":
     -+				break;
     -+		}
     -+		(int, int) tuple = (1, 4);
     -+		switch (tuple)
     -+		{
     -+			case (1, 4):
     -+				MethodCall();
     -+		}
     -+		
     -+		// Exceptions
     -+		try
     -+		{
     -+			throw new Exception("fail");
     -+		}
     -+		catch (Exception)
     -+		{
     -+		}
     -+		finally
     -+		{
     -+		}
     -+		try { } catch (Exception) {}
     -+		try
     -+		{
     -+			throw GetException(
     -+				);
     -+		}
     -+		catch (Exception) { }
     -+		
     -+		// Others
     -+		lock (this)
     -+		{
     -+		}
     -+		unsafe
     -+		{
     -+			byte[] bytes = [1, 2, 3];
     -+			fixed (byte* pointerToFirst = bytes)
     -+			{
     -+			}
     -+		}
     -+		
     -+		return "ChangeMe";
     -+	}
     -+	
     -+	public void Dispose() {}
     -+	
     -+	string MethodCall(int a = 0, int b = 0) => "test";
     -+	Exception GetException() => new Exception("fail");
     -+	int[] Numbers() => [0, 1];
     ++    string Method(int RIGHT)
     ++    {
     ++        // Method calls
     ++        MethodCall();
     ++        MethodCall(1, 2);
     ++        MethodCall(
     ++            1, 2);
     ++
     ++        // Assignments
     ++        var constantAssignment = "test";
     ++        var methodAssignment = MethodCall();
     ++        var multiLineMethodAssignment = MethodCall(
     ++        );
     ++        var multiLine = "first"
     ++            + MethodCall()
     ++            - MethodCall()
     ++            + MethodCall();
     ++
     ++        // Initializations/disposal
     ++        new Example();
     ++        new Example(
     ++            );
     ++        new Example { };
     ++        using (this)
     ++        {
     ++        }
     ++        var def =
     ++            this is default(
     ++                Example);
     ++
     ++        // Iteration statements
     ++        do { } while (true);
     ++        do MethodCall(
     ++        ); while (true);
     ++        while (true);
     ++        while (true) {
     ++            break;
     ++        }
     ++        for (int i = 0; i < 10; ++i)
     ++        {
     ++        }
     ++        foreach (int i in Enumerable.Range(0, 10))
     ++        {
     ++        }
     ++        int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
     ++
     ++        // Control
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
     ++            MethodCall();
     ++        }
     ++
     ++        // Exceptions
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
     ++        // Others
     ++        lock (this)
     ++        {
     ++        }
     ++        unsafe
     ++        {
     ++            byte[] bytes = [1, 2, 3];
     ++            fixed (byte* pointerToFirst = bytes)
     ++            {
     ++            }
     ++        }
     ++
     ++        return "ChangeMe";
     ++    }
     ++
     ++    // Supporting methods to make the tested method above valid C#.
     ++    public void Dispose() {}
     ++    string MethodCall(int a = 0, int b = 0) => "test";
     ++    Exception GetException() => new Exception("fail");
     ++    int[] Numbers() => [0, 1];
      +}
      
       ## t/t4018/csharp-method-special-chars (new) ##
      @@
      +class @Some_Type
      +{
     -+	@Some_Type @Method_With_Underscore(int RIGHT)
     -+	{
     -+		// Filler
     -+		// Filler
     -+		
     -+		// ChangeMe
     -+		return new @Some_Type();
     -+	}
     ++    @Some_Type @Method_With_Underscore(int RIGHT)
     ++    {
     ++        // Filler
     ++        // Filler
     ++        
     ++        // ChangeMe
     ++        return new @Some_Type();
     ++    }
      +}
      
       ## t/t4018/csharp-method-with-spacing (new) ##
     @@ t/t4018/csharp-method-with-spacing (new)
      +{
      +		string   Method 	( int 	RIGHT )
      +	{
     -+		// Filler
     -+		// Filler
     ++        // Filler
     ++        // Filler
      +		
     -+		return "ChangeMe";
     -+	}
     ++        return "ChangeMe";
     ++    }
      +}
      
       ## t/t4018/csharp-property (new) ##
      @@
      +class Example
      +{
     -+	public bool RIGHT
     ++    public bool RIGHT
      +    {
      +        get { return true; }
      +        set
     @@ t/t4018/csharp-property (new)
      +            // ChangeMe
      +        }
      +    }
     ++}
     +
     + ## t/t4018/csharp-property-skip-body (new) ##
     +@@
     ++using System.Linq;
     ++using System;
     ++
     ++class Example : IDisposable
     ++{
     ++    public string RIGHT
     ++    {
     ++        get
     ++        {
     ++            // Method calls
     ++            MethodCall();
     ++            MethodCall(1, 2);
     ++            MethodCall(
     ++                1, 2);
     ++
     ++            // Assignments
     ++            var constantAssignment = "test";
     ++            var methodAssignment = MethodCall();
     ++            var multiLineMethodAssignment = MethodCall(
     ++                );
     ++            var multiLine = "first"
     ++                + MethodCall()
     ++                - MethodCall()
     ++                + MethodCall();
     ++
     ++            // Initializations/disposal
     ++            new Example();
     ++            new Example(
     ++                );
     ++            new Example { };
     ++            using (this)
     ++            {
     ++            }
     ++            var def =
     ++                this is default(
     ++                    Example);
     ++
     ++            // Iteration statements
     ++            do { } while (true);
     ++            do MethodCall(
     ++            ); while (true);
     ++            while (true);
     ++            while (true) {
     ++                break;
     ++            }
     ++            for (int i = 0; i < 10; ++i)
     ++            {
     ++            }
     ++            foreach (int i in Enumerable.Range(0, 10))
     ++            {
     ++            }
     ++            int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
     ++
     ++            // Control
     ++            if (false)
     ++            {
     ++                return "out";
     ++            }
     ++            else { }
     ++            if (true) MethodCall(
     ++            );
     ++            else MethodCall(
     ++            );
     ++            switch ("test")
     ++            {
     ++                case "one":
     ++                return MethodCall(
     ++                );
     ++                case "two":
     ++                break;
     ++            }
     ++            (int, int) tuple = (1, 4);
     ++            switch (tuple)
     ++            {
     ++                case (1, 4):
     ++                MethodCall();
     ++            }
     ++
     ++            // Exceptions
     ++            try
     ++            {
     ++                throw new Exception("fail");
     ++            }
     ++            catch (Exception)
     ++            {
     ++            }
     ++            finally
     ++            {
     ++            }
     ++            try { } catch (Exception) {}
     ++            try
     ++            {
     ++                throw GetException(
     ++                );
     ++            }
     ++            catch (Exception) { }
     ++
     ++            // Others
     ++            lock (this)
     ++            {
     ++            }
     ++            unsafe
     ++            {
     ++                byte[] bytes = [1, 2, 3];
     ++                fixed (byte* pointerToFirst = bytes)
     ++                {
     ++                }
     ++            }
     ++
     ++            return "ChangeMe";
     ++        }
     ++        set { }
     ++    }
     ++
     ++    // Supporting methods to make the tested property above valid C#.
     ++    public void Dispose() {}
     ++    string MethodCall(int a = 0, int b = 0) => "test";
     ++    Exception GetException() => new Exception("fail");
     ++    int[] Numbers() => [0, 1];
      +}
      
       ## userdiff.c ##
     @@ userdiff.c: PATTERNS("cpp",
      -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
      -	 /* Methods and constructors */
      -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
     +-	 /* Properties */
     +-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
      +	 /*
     -+	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
     ++	  * Jump over reserved keywords which are illegal method names, but which
     ++	  * can be followed by parentheses without special characters in between,
      +	  * making them look like methods.
      +	  */
      +	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
     -+	 /* Methods/constructors:
     -+	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
     -+	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.
     ++	 /*
     ++	  * Methods/constructors:
     ++	  * The strategy is to identify a minimum of two groups (any combination
     ++	  * of keywords/type/name), without intermediate characters which can't be
     ++	  * part of method definitions before the opening parenthesis, and without
     ++	  * final unexpected characters, normally only used in ordinary statements.
     ++	  * "=" is excluded to ignore assignments, but as a result rules out
     ++	  * methods with expression bodies. However, since those fit on 1-2 lines,
     ++	  * a chunk header isn't useful either way.
      +	  */
     -+	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
     - 	 /* Properties */
     --	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
     -+	 "^[ \t]*((([][[:alnum:]@_<>.,]+)[ \t]+[][[:alnum:]@_]*)+[^=:;,()]*)$\n"
     ++	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t+*%\\/\\-][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
     ++	 /*
     ++	  * Properties:
     ++	  * As with methods, expect a minimum of two groups. And, the vast majority
     ++	  * of properties long enough to be worth showing a chunk header for don't
     ++	  * include "=:;,()" on the line they are defined.
     ++	  */
     ++	 "^[ \t]*([][[:alnum:]@_<>.,]+[ \t]+[][[:alnum:]@_.]+[^=:;,()]*)$\n"
       	 /* Type definitions */
       	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
       	 /* Namespace */


 t/t4018/csharp-method               |  10 +++
 t/t4018/csharp-method-explicit      |  12 +++
 t/t4018/csharp-method-generics      |  11 +++
 t/t4018/csharp-method-modifiers     |  13 +++
 t/t4018/csharp-method-multiline     |  10 +++
 t/t4018/csharp-method-params        |  10 +++
 t/t4018/csharp-method-skip-body     | 116 +++++++++++++++++++++++++++
 t/t4018/csharp-method-special-chars |  11 +++
 t/t4018/csharp-method-with-spacing  |  10 +++
 t/t4018/csharp-property             |  11 +++
 t/t4018/csharp-property-skip-body   | 120 ++++++++++++++++++++++++++++
 userdiff.c                          |  30 +++++--
 12 files changed, 358 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/csharp-method
 create mode 100644 t/t4018/csharp-method-explicit
 create mode 100644 t/t4018/csharp-method-generics
 create mode 100644 t/t4018/csharp-method-modifiers
 create mode 100644 t/t4018/csharp-method-multiline
 create mode 100644 t/t4018/csharp-method-params
 create mode 100644 t/t4018/csharp-method-skip-body
 create mode 100644 t/t4018/csharp-method-special-chars
 create mode 100644 t/t4018/csharp-method-with-spacing
 create mode 100644 t/t4018/csharp-property
 create mode 100644 t/t4018/csharp-property-skip-body

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
diff --git a/t/t4018/csharp-method-skip-body b/t/t4018/csharp-method-skip-body
new file mode 100644
index 00000000000..b3c7194eb74
--- /dev/null
+++ b/t/t4018/csharp-method-skip-body
@@ -0,0 +1,116 @@
+using System.Linq;
+using System;
+
+class Example : IDisposable
+{
+    string Method(int RIGHT)
+    {
+        // Method calls
+        MethodCall();
+        MethodCall(1, 2);
+        MethodCall(
+            1, 2);
+
+        // Assignments
+        var constantAssignment = "test";
+        var methodAssignment = MethodCall();
+        var multiLineMethodAssignment = MethodCall(
+        );
+        var multiLine = "first"
+            + MethodCall()
+            - MethodCall()
+            + MethodCall();
+
+        // Initializations/disposal
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
+        // Iteration statements
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
+        // Control
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
+            MethodCall();
+        }
+
+        // Exceptions
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
+        // Others
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
+
+    // Supporting methods to make the tested method above valid C#.
+    public void Dispose() {}
+    string MethodCall(int a = 0, int b = 0) => "test";
+    Exception GetException() => new Exception("fail");
+    int[] Numbers() => [0, 1];
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
index 00000000000..da0c9b7e60c
--- /dev/null
+++ b/t/t4018/csharp-method-with-spacing
@@ -0,0 +1,10 @@
+class Example
+{
+		string   Method 	( int 	RIGHT )
+	{
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
diff --git a/t/t4018/csharp-property-skip-body b/t/t4018/csharp-property-skip-body
new file mode 100644
index 00000000000..ad9d96007a8
--- /dev/null
+++ b/t/t4018/csharp-property-skip-body
@@ -0,0 +1,120 @@
+using System.Linq;
+using System;
+
+class Example : IDisposable
+{
+    public string RIGHT
+    {
+        get
+        {
+            // Method calls
+            MethodCall();
+            MethodCall(1, 2);
+            MethodCall(
+                1, 2);
+
+            // Assignments
+            var constantAssignment = "test";
+            var methodAssignment = MethodCall();
+            var multiLineMethodAssignment = MethodCall(
+                );
+            var multiLine = "first"
+                + MethodCall()
+                - MethodCall()
+                + MethodCall();
+
+            // Initializations/disposal
+            new Example();
+            new Example(
+                );
+            new Example { };
+            using (this)
+            {
+            }
+            var def =
+                this is default(
+                    Example);
+
+            // Iteration statements
+            do { } while (true);
+            do MethodCall(
+            ); while (true);
+            while (true);
+            while (true) {
+                break;
+            }
+            for (int i = 0; i < 10; ++i)
+            {
+            }
+            foreach (int i in Enumerable.Range(0, 10))
+            {
+            }
+            int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
+
+            // Control
+            if (false)
+            {
+                return "out";
+            }
+            else { }
+            if (true) MethodCall(
+            );
+            else MethodCall(
+            );
+            switch ("test")
+            {
+                case "one":
+                return MethodCall(
+                );
+                case "two":
+                break;
+            }
+            (int, int) tuple = (1, 4);
+            switch (tuple)
+            {
+                case (1, 4):
+                MethodCall();
+            }
+
+            // Exceptions
+            try
+            {
+                throw new Exception("fail");
+            }
+            catch (Exception)
+            {
+            }
+            finally
+            {
+            }
+            try { } catch (Exception) {}
+            try
+            {
+                throw GetException(
+                );
+            }
+            catch (Exception) { }
+
+            // Others
+            lock (this)
+            {
+            }
+            unsafe
+            {
+                byte[] bytes = [1, 2, 3];
+                fixed (byte* pointerToFirst = bytes)
+                {
+                }
+            }
+
+            return "ChangeMe";
+        }
+        set { }
+    }
+
+    // Supporting methods to make the tested property above valid C#.
+    public void Dispose() {}
+    string MethodCall(int a = 0, int b = 0) => "test";
+    Exception GetException() => new Exception("fail");
+    int[] Numbers() => [0, 1];
+}
diff --git a/userdiff.c b/userdiff.c
index e399543823b..5440ccf2de5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -89,12 +89,30 @@ PATTERNS("cpp",
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
+	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
+	 /*
+	  * Methods/constructors:
+	  * The strategy is to identify a minimum of two groups (any combination
+	  * of keywords/type/name), without intermediate characters which can't be
+	  * part of method definitions before the opening parenthesis, and without
+	  * final unexpected characters, normally only used in ordinary statements.
+	  * "=" is excluded to ignore assignments, but as a result rules out
+	  * methods with expression bodies. However, since those fit on 1-2 lines,
+	  * a chunk header isn't useful either way.
+	  */
+	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t+*%\\/\\-][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
+	 /*
+	  * Properties:
+	  * As with methods, expect a minimum of two groups. And, the vast majority
+	  * of properties long enough to be worth showing a chunk header for don't
+	  * include "=:;,()" on the line they are defined.
+	  */
+	 "^[ \t]*([][[:alnum:]@_<>.,]+[ \t]+[][[:alnum:]@_.]+[^=:;,()]*)$\n"
 	 /* Type definitions */
 	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
 	 /* Namespace */

base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
-- 
gitgitgadget
