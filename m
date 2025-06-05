Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9231F8724
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102684; cv=none; b=m+M/4ydSoEIrB3SVrDNaOnylM9jZgBooZ21lcCsmoNPu8xcUrQmLX2byBQeyNSU6J1LHtViXMO4buoUA55IPfZX239VddsbFyb2tsZ+bu92xF9uFo5g2LClazEMJTVDMgY3pEiMi4ZqHbLFHfA8RDGjBBc51UnyPKAr2DnbS0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102684; c=relaxed/simple;
	bh=BRUzB4Zivs1RG4TmF78mv40iOyHN64pB9pT3qXXrvHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RMPDpot/NCpXvT41N/dZHvbH2Esi7Yb8DEf37B1xwJmx3zcB6kqntjBaRUK8IoZzYXRPO2d+sPj5RRGkhES++8YUIabe4zqUlozCXAIhUZAkxgEXzf1hxIxX7qq2jkB5lOJZoznRk9s99BfA/rQCOB6vmy4MROzHHPXckRYbeLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bCYTt1pndz7R1Kx
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 07:51:14 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bCYTj5YfmzRnPp;
	Thu,  5 Jun 2025 07:51:05 +0200 (CEST)
Message-ID: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
Date: Thu, 5 Jun 2025 07:51:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH 1/1] userdiff: add javascript diff driver
To: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
References: <20250604094100.80598-1-derick.william.moraes@gmail.com>
 <20250604094100.80598-2-derick.william.moraes@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250604094100.80598-2-derick.william.moraes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for your contribution. We have had a number of submissions for
Javascript or Typescript drivers in the past, but none of them were
followed through to be integrated.

Typescript:

https://lore.kernel.org/git/20240404163827.5855-1-utsavp0213@gmail.com/
https://lore.kernel.org/git/pull.1746.git.git.1721061218993.gitgitgadget@gmail.com/

Javascript:

https://lore.kernel.org/git/20240301074048.188835-1-sergiusnyah@gmail.com/
https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/

Please review these submission and the responses that they received.
Perhaps you can find inspiration for improvement from them.

Since this patch is marked as [GSoC], I'll comment on the style a bit,
but do not go into the depth of the patch itself too far, yet. Please
let us know if one of the earlier submissions can be revived or reused
in some way.

Am 04.06.25 um 11:35 schrieb Derick W. de M. Frias:
> Add a userdiff pattern for javascript, and 13 test cases for instances
> of function declarations in javascript.

This is written in imperative mood, which is good. A minor
recommendation: Don't mention the number of test cases here; it might go
stale if the patch is updated.

> 
> Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
> ---
>  .../javascript-anonymous-function-assigned    |  4 +++
>  t/t4018/javascript-arrow-function-assigned    |  4 +++
>  t/t4018/javascript-arrow-function-assigned-2  |  1 +
>  t/t4018/javascript-async-function             |  4 +++
>  t/t4018/javascript-async-function-assigned    |  4 +++
>  t/t4018/javascript-class-function             |  6 ++++
>  t/t4018/javascript-function                   |  4 +++
>  t/t4018/javascript-function-assigned          |  4 +++
>  t/t4018/javascript-generator-function         |  5 ++++
>  t/t4018/javascript-generator-function-2       |  5 ++++
>  .../javascript-generator-function-assigned    |  5 ++++
>  .../javascript-generator-function-assigned-2  |  5 ++++
>  t/t4018/javascript-method-function            |  6 ++++
>  userdiff.c                                    | 28 +++++++++++++++++++
>  14 files changed, 85 insertions(+)
>  create mode 100644 t/t4018/javascript-anonymous-function-assigned
>  create mode 100644 t/t4018/javascript-arrow-function-assigned
>  create mode 100644 t/t4018/javascript-arrow-function-assigned-2
>  create mode 100644 t/t4018/javascript-async-function
>  create mode 100644 t/t4018/javascript-async-function-assigned
>  create mode 100644 t/t4018/javascript-class-function
>  create mode 100644 t/t4018/javascript-function
>  create mode 100644 t/t4018/javascript-function-assigned
>  create mode 100644 t/t4018/javascript-generator-function
>  create mode 100644 t/t4018/javascript-generator-function-2
>  create mode 100644 t/t4018/javascript-generator-function-assigned
>  create mode 100644 t/t4018/javascript-generator-function-assigned-2
>  create mode 100644 t/t4018/javascript-method-function
> 
> diff --git a/t/t4018/javascript-anonymous-function-assigned b/t/t4018/javascript-anonymous-function-assigned
> new file mode 100644
> index 0000000000..d3c1728dd8
> --- /dev/null
> +++ b/t/t4018/javascript-anonymous-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT = function (a, b) {	
> +
> +    return a + b;
> +};
> \ No newline at end of file

We avoid incomplete last lines in this code base if it is not mandated
for some reason.

Here and in the later test cases, the word "ChangeMe" is missing. How
did these ever pass the tests?

> diff --git a/t/t4018/javascript-arrow-function-assigned b/t/t4018/javascript-arrow-function-assigned
> new file mode 100644
> index 0000000000..5f0b056f61
> --- /dev/null
> +++ b/t/t4018/javascript-arrow-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT = (a, b) => {
> +	
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-arrow-function-assigned-2 b/t/t4018/javascript-arrow-function-assigned-2
> new file mode 100644
> index 0000000000..9e923f4261
> --- /dev/null
> +++ b/t/t4018/javascript-arrow-function-assigned-2
> @@ -0,0 +1 @@
> +const RIGHT = a => a+1;
> \ No newline at end of file
> diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
> new file mode 100644
> index 0000000000..7f99b8c89a
> --- /dev/null
> +++ b/t/t4018/javascript-async-function
> @@ -0,0 +1,4 @@
> +async function RIGHT (a, b) {
> +	
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-async-function-assigned b/t/t4018/javascript-async-function-assigned
> new file mode 100644
> index 0000000000..9a01d9701f
> --- /dev/null
> +++ b/t/t4018/javascript-async-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT = async function (a, b) {
> +	
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-class-function b/t/t4018/javascript-class-function
> new file mode 100644
> index 0000000000..9f216d7174
> --- /dev/null
> +++ b/t/t4018/javascript-class-function
> @@ -0,0 +1,6 @@
> +class Test {
> +  RIGHT() {
> +    let a = 1;
> +    let b = Value;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
> new file mode 100644
> index 0000000000..d11ad34aff
> --- /dev/null
> +++ b/t/t4018/javascript-function
> @@ -0,0 +1,4 @@
> +function RIGHT (a, b) {
> +	
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-assigned b/t/t4018/javascript-function-assigned
> new file mode 100644
> index 0000000000..38eaecafc6
> --- /dev/null
> +++ b/t/t4018/javascript-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT = function test (a, b) {
> +	
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
> new file mode 100644
> index 0000000000..af7cbb50a3
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function
> @@ -0,0 +1,5 @@
> +function* RIGHT() {
> +  
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
> new file mode 100644
> index 0000000000..d40b395f5c
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-2
> @@ -0,0 +1,5 @@
> +function *RIGHT() {
> +  
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-assigned b/t/t4018/javascript-generator-function-assigned
> new file mode 100644
> index 0000000000..b45d069949
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-assigned
> @@ -0,0 +1,5 @@
> +const RIGHT = function* (){
> +  
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-assigned-2 b/t/t4018/javascript-generator-function-assigned-2
> new file mode 100644
> index 0000000000..2c4bc271ab
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-assigned-2
> @@ -0,0 +1,5 @@
> +const RIGHT = function *(){
> +  
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-method-function b/t/t4018/javascript-method-function
> new file mode 100644
> index 0000000000..37e380cc6f
> --- /dev/null
> +++ b/t/t4018/javascript-method-function
> @@ -0,0 +1,6 @@
> +const Test = {
> +  RIGHT() {
> +    let a = 1;
> +    let b = Value;
> +  }
> +}
> \ No newline at end of file
> diff --git a/userdiff.c b/userdiff.c
> index 05776ccd10..94134e5b09 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -237,6 +237,34 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("javascript",

The following lines are indented by spaces. We use TAB here.

> +     /* conventional named functions */
> +     "^[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\(.*$|"
> +     /* assigned functions */
> +     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
> +     "[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)?[ \t]*\\(.*$|"
> +     /* arrow functions */
> +     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
> +     "[ \t]*(\\([^\\)]*\\)|[$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=>[ \t]*\\{?.*$|"
> +     /* functions declared inside classes and objects */
> +     "^[ \t]*(static[ \t]+)?(async[ \t]+)?(get[ \t]+|set[ \t]+)?\\*?[ \t]*"
> +     "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\([^)]*\\)[ \t]*\\{.*$",
> +     /* identifiers */
> +	 "[$_A-Za-z][$_A-Za-z0-9]*|"
> +     /* hexadecimal and big hexadecimal */
> +     "0[xX](?:[0-9a-fA-F](?:_?[0-9a-fA-F])*)n?|"
> +     /* octa and big octa */
> +     "0[oO](?:[0-7](?:_?[0-7])*)n?|"
> +     /* binary and big binary */
> +     "0[bB](?:[01](?:_?[01])*)n?|"
> +     /* decimal, floting point and exponent notation (eE) */
> +     "(?:0|[1-9](?:_?[0-9])*)(?:\\.(?:[0-9](?:_?[0-9])*))?(?:[eE][+-]?(?:[0-9](?:_?[0-9])*))?|"
> +     /* big decimal */
> +     "(?:0|[1-9](?:_?[0-9])*)n|"
> +	 /* punctuation */
> +	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
> +	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
> +	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"),

You do not have to include single-character punctuation; these are
recognized as words automatically.

Personally I prefer |===| over |={3}| (and similar for the others)
because it is easier to understand.

>  PATTERNS("kotlin",
>  	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
>  	 /* -- */

-- Hannes

