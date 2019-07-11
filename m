Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D271F461
	for <e@80x24.org>; Thu, 11 Jul 2019 13:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKNf1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 09:35:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKNf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 09:35:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so6330962wrl.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xZuYQhM+Xm3HD1+IuYlmAEkQysDp7XBHsIp0n4osp1A=;
        b=W0PMVobEKMfZJ0KkjIqgKWlL5l5CR6OTtgWxooUHl965iB7ds/ZnHaFe83B5ZMKyWQ
         M3EzXI5Bee8gV/DFXV24T8EMSAFrV0TAuukAQ1en+1gAerUUNtaDl1U6rVf/X87uWC4P
         s/o37huAndy1uHt5RPCAg2gZ0w9H1Ly57DtYnMwTkYPQ9e/LLoEBgB3683S1uR910UmB
         HFY3E3dAGB7sob2hqWx8Du3+Vp60cj7LuBx49aTy7UDhkHZnKo6A27bIIYIfIL2SvFeu
         zSvDtrQnpXEWonPv1VoGf/6B0h6p5sc6SjeRtYK0wRd35/VvMtnu66rmfN8WNYKZBqa7
         /ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xZuYQhM+Xm3HD1+IuYlmAEkQysDp7XBHsIp0n4osp1A=;
        b=bRZYx5+AiU7XcLo3TP0ifu6B8gEZM7No7/qp080T4lktY1rt+SmUrpZ4qdvDSj7tHz
         8OtNgDjS3HBc7lbp8PNXYbLIPP8JgyfQwkzOaDIIuyiRmG+fsgpvPR1OclGkkg8p+1eF
         b9kLIOa3omAxgE4Oh9DGTBCudY7dCM+jU2BW17bhDk9QHnpX0P4RKGhF47Sx25tlhu04
         +Dc/5/4buoxYw6Jenqm/iIdK595snvPjeCJ1GK0IMJ14A4ODumWxsldkHRAqafmDfDYm
         2XrUm1aolXinE3zfvsDcaKtK/wJLC6vI23c+Tqc+RPMdinc5nMrw4hSH8TewsXgjba5k
         Y9Hw==
X-Gm-Message-State: APjAAAV9K6UX0GyO0Ld7FeQNHvAEBmMfKUIPxY9hizRPqG032QqMWHiY
        u4Mow+cqdazLsFTCyzGEIjLjnP9ZPxs=
X-Google-Smtp-Source: APXvYqx99EgzO3wMLk/MkhRgVIQfhrXe89wPv+uy4VwsDPyAjJdyfRk50dsM9bedMxIwb3fh2XayDQ==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr5253800wrq.261.1562852123999;
        Thu, 11 Jul 2019 06:35:23 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd227.neoplus.adsl.tpnet.pl. [83.21.67.227])
        by smtp.gmail.com with ESMTPSA id v204sm4983383wma.20.2019.07.11.06.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 06:35:23 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [RFC PATCH v2 2/3] trace2: add a schema validator for trace2 events
References: <cover.1560295286.git.steadmon@google.com>
        <cover.1562712943.git.steadmon@google.com>
        <3fa4e9eef84ba00c631c82fb3a2eacb8439df9e5.1562712943.git.steadmon@google.com>
Date:   Thu, 11 Jul 2019 15:35:20 +0200
In-Reply-To: <3fa4e9eef84ba00c631c82fb3a2eacb8439df9e5.1562712943.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 9 Jul 2019 16:05:44 -0700")
Message-ID: <86muhkae3r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> trace_schema_validator can be used to verify that trace2 event output
> conforms to the expectations set by the API documentation and codified
> in event_schema.json (or strict_schema.json). This allows us to build a
> regression test to verify that trace2 output does not change
> unexpectedly.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Very nitpicky comments below.

> ---
>  t/trace_schema_validator/.gitignore           |  1 +
>  t/trace_schema_validator/Makefile             | 10 +++
>  .../trace_schema_validator.go                 | 78 +++++++++++++++++++
>  3 files changed, 89 insertions(+)
>  create mode 100644 t/trace_schema_validator/.gitignore
>  create mode 100644 t/trace_schema_validator/Makefile
>  create mode 100644 t/trace_schema_validator/trace_schema_validator.go
>
> diff --git a/t/trace_schema_validator/.gitignore b/t/trace_schema_validator/.gitignore
> new file mode 100644
> index 0000000000..c3f1e04e9e
> --- /dev/null
> +++ b/t/trace_schema_validator/.gitignore
> @@ -0,0 +1 @@
> +trace_schema_validator
> diff --git a/t/trace_schema_validator/Makefile b/t/trace_schema_validator/Makefile
> new file mode 100644
> index 0000000000..ed22675e5d
> --- /dev/null
> +++ b/t/trace_schema_validator/Makefile
> @@ -0,0 +1,10 @@
> +.PHONY: fetch_deps clean
> +
> +trace_schema_validator: fetch_deps trace_schema_validator.go
> +	go build

I don't know the Go build process, but shouldn't the name of target and
the name of actual source file passed to the command?

Though I don't think we would _need_ for example being able to configure
Go build process via Makefile variables, like e.g. $(GOBUILD) in
https://sohlich.github.io/post/go_makefile/

> +
> +fetch_deps:
> +	go get github.com/xeipuuv/gojsonschema
> +
> +clean:
> +	rm -f trace_schema_validator

In git Makefile we use

  clean:
  	$(RM) $(PROGRAMS)

I'm not sure if it is needed for operating system independence, but
using $(RM) is a standard way to create 'clean' targets...

> diff --git a/t/trace_schema_validator/trace_schema_validator.go
> b/t/trace_schema_validator/trace_schema_validator.go
> new file mode 100644
> index 0000000000..f779ac5ff5
> --- /dev/null
> +++ b/t/trace_schema_validator/trace_schema_validator.go
> @@ -0,0 +1,78 @@
> +// trace_schema_validator validates individual lines of an input file against a
> +// provided JSON-Schema for git trace2 event output.
> +//
> +// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
> +// to an absolute path and running any Git command; traces will be appended to
> +// the file.
> +//
> +// Traces can then be verified like so:
> +//   trace_schema_validator \
> +//     --trace2_event_file /path/to/trace/output \
> +//     --schema_file /path/to/schema
> +package main
> +
> +import (
> +	"bufio"
> +	"flag"
> +	"log"
> +	"os"
> +	"path/filepath"
> +
> +	"github.com/xeipuuv/gojsonschema"
> +)
> +
> +// Required flags
> +var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
> +var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")

The standard for long options is to use "kebab case", not "snake case"
for them, i.e. --schema-file not current --schema_file, etc.

> +
> +func main() {
> +	flag.Parse()
> +	if *schemaFile == "" || *trace2EventFile == "" {
> +		log.Fatal("Both --schema_file and --trace2_event_file are required.")
> +	}

I guess that you prefer required options with explicit arguments instead
of positional arguments (that is requiring the command to be called with
two arguments, first being schema file, second being event file to
validate).

> +	schemaURI, err := filepath.Abs(*schemaFile)
> +	if err != nil {
> +		log.Fatal("Can't get absolute path for schema file: ", err)
> +	}
> +	schemaURI = "file://" + schemaURI
> +
> +	schemaLoader := gojsonschema.NewReferenceLoader(schemaURI)
> +	schema, err := gojsonschema.NewSchema(schemaLoader)
> +	if err != nil {
> +		log.Fatal("Problem loading schema: ", err)
> +	}
> +
> +	tracesFile, err := os.Open(*trace2EventFile)
> +	if err != nil {
> +		log.Fatal("Problem opening trace file: ", err)
> +	}
> +	defer tracesFile.Close()
> +
> +	scanner := bufio.NewScanner(tracesFile)
> +
> +	count := 0
> +	for ; scanner.Scan(); count++ {

I see that you assume JSON-Lines format, i.e. one JSON object per line
in the file.

> +		if count%10000 == 0 {
> +			// Travis-CI expects regular output or it will time out.
> +			log.Print("Validated items: ", count)

I wonder if it wouldn't be better to provide --progress flag, which
Travis-CI job would turn on.

> +		}
> +		event := gojsonschema.NewStringLoader(scanner.Text())
> +		result, err := schema.Validate(event)
> +		if err != nil {
> +			log.Fatal(err)
> +		}
> +		if !result.Valid() {
> +			log.Print("Trace event is invalid: ", scanner.Text())

It might be good idea to print the line (i.e. the value of `count`
variable).

I guess that conforming to the <filename>:<line>: prefix (like e.g. gcc
uses for errors) would be unnecessary.

> +			for _, desc := range result.Errors() {
> +				log.Print("- ", desc)
> +			}
> +			os.Exit(1)
> +		}
> +	}
> +
> +	if err := scanner.Err(); err != nil {
> +		log.Fatal("Scanning error: ", err)
> +	}
> +
> +	log.Print("Validated events: ", count)
> +}
