Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD9F211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 02:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeLAOJr (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 09:09:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39053 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLAOJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 09:09:47 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so1373082itl.4
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 18:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsULyTi8NCPGD+gGR0wOgiZi+wubVolEa8/fC9pryg4=;
        b=Q7Ekf9GbWhvPK7pffbB/ZOTu38wMGqZkxPWO9/ZM+uglTY3777E5urC3hQCNe9q5pc
         jR/UZrmYnEiLI8GvhO7ChBhwV3b+lDbzFJ/i79BpjHPzJroNgqCGimewswqCL76TsS2v
         nFHTiDop21hqI5thvLzAU6mENyLAn/5gihAVoH4Sg6BC02EwVDRwbCJe/oBUOQ9W4w8a
         p8Pwnp2hzq2fd54PENkhw+ZL7KDCt7LsH0VjOgOYltxZm9vH7oGW2pTgquHmhspqKS41
         EqfjHvDBOpep1QUfDaX8gfcoh2So7BdTzHSOLm4wA/KVukIgaoqUkm33sdg7kYXaWTe2
         92NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsULyTi8NCPGD+gGR0wOgiZi+wubVolEa8/fC9pryg4=;
        b=gvfp6cMmaaju8aZQyt+d81AVfVJCctUY40CkfO0mYGCgFW2PcJeWS4TanwG97/9p4U
         Rgp6I7+CpEpBMy1wOMpooUH9MFKFVSHdyzGlYcZH/KE+UqICtOTHybKwYwMr0d8A3aRU
         2XPNaPeDxYmvmUHY2l9ZGlbhq1hl+lCdT7DDxY4svPB+0T40dJ0Oz1qIp+K2VEiBAMyl
         76/W0v+e4va9nU4lTaIVeir1qL0zNKazivTtgktKU2vbVuez+mKaB0EF+hXtBnxHC+7X
         iQaXXqrYEgD4bZ24WIiW3tUDgCIMvhP5tHIJ+j8/ELAUQOuGrUxsMVXddjP+iFG3lk5T
         WttQ==
X-Gm-Message-State: AA+aEWa3J9PEHF8AeHePj3Rlvl6D1UZkTtOfYw1/kl5gv7qli/eGau7X
        tv/yQ1OMVT6cqGtjCWECGAZXBdtv3FWS4q8w2jFM8Q==
X-Google-Smtp-Source: AFSGD/URKsqQ/1cysen++bo6Hj0btUXEgVxOzHF9/AQjNcy40lKI5tgV9cgHJFAYygrdx1dzbAXup/K6EMDKqrbIxBo=
X-Received: by 2002:a24:5e05:: with SMTP id h5mr1148625itb.103.1543633100758;
 Fri, 30 Nov 2018 18:58:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYAzOd8qwEDgVf-W+1S3NoZFUa_vZsUfuNNjL_XsuesO5w@mail.gmail.com>
In-Reply-To: <CAFd4kYAzOd8qwEDgVf-W+1S3NoZFUa_vZsUfuNNjL_XsuesO5w@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 30 Nov 2018 18:58:09 -0800
Message-ID: <CAGyf7-Eq6tQQocjXFzngX=vo3FWba=tvmAqGybcLxLXn6ZZkpA@mail.gmail.com>
Subject: Re: Parsing a git HTTP protocol response
To:     khanzf@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 5:05 PM Farhan Khan <khanzf@gmail.com> wrote:
>
> Hi all,
>
> I am writing an implementation of the git HTTP pack protocol in C. It
> just does a request to clone a repository. It works pretty well for
> small repositories, but seems to fail on larger repositories and I do
> not understand why.
>
> All that my code does is send a hard-coded "want" request. As I
> understand it, responses come with a four-byte size prefix, then the
> data of the size - 4. The first four bytes are the size of the object
> in ASCII and after that size, a new object should begin by specifying
> its size. The final "0000" string should signify the end.
>
> On small repositories my code works fine. But when use a large git
> repository, I hit an object size that cannot be interpreted by ASCII
> into a number. In particular, right before the crash I am pretty
> consistently getting a size starting with 0x32,0x00 or 0x32,0x30,0x00
> (note, it starts with 0x32 and has 0x00 in there). This is not a
> readable four byte ascii value, likely an erroneous size value, which
> causes the next object size calculation to land incorrectly and
> subsequently the program to malfunction.
>
> My questions:
> 1. Am I misunderstanding the protocol?
> 2. Does 0x32 signify something?
> 3. Also, where can I see in the source code git parses the data it
> receives from a "want" request?
>
> If you would like to see my code, it is located here:
> http://git.farhan.codes/farhan/post
> To compile to Linux run: gcc post.c main.c -lcurl -o post
> To compile on FreeBSD you can use the Makefile or: cc -L
> /usr/local/lib -I /usr/local/include -lcurl main.c post.c -o post
> In both cases you need to have libcurl installed.
>
> To run do: ./post [a git http url] [a commit value]
> ie: ./post http://git.farhan.codes/farhan/openbsd
> 373dd5ba116d42cddf1fdcb58b578a4274f6d589
>
> I have a lot of debugging printf() messages, but it eventually hits a
> point where you see this:
>
> ========Start=========
> Current stats: Current state: 999 Received: 1448
> We have enough bytes, moving forward
> == New Object
> No Error, object is 32 bytes
> Size bytes: 32 30 00 00

I modified your debugging output a little bit, and right before the
failure happens I see this in my output:

========Start=========
Current stats: Current state: 999 Received: 1298
Read complete; still missing 1296 bytes (6901 read of 8197)
Offset: 1298

========Start=========
Current stats: Current state: 999 Received: 1298
Read complete; 2 more bytes in buffer
== New Object
Size bytes: 32 30 00 2b

Based on that, it appears what's happening is you're not handling the
case where you end up with fewer than 4 bytes in the buffer. As a
result, memcpy reads past the end of the response buffer and gets
whatever it gets, resulting in an incorrect parsed size.

The while loop in pack_protocol_line is checking +1, but I think it
should be checking +3 to ensure there's at least 4 bytes so it can get
a complete size. The "parseread" struct will need to grow a couple
more fields to allow buffering some additional bytes between
pack_protocol_line calls (because curl requires the write function to
always consume the full buffer) and, at the start of the loop, when
reading/parsing a size, the code will need to consider any buffered
bytes from the previous function call. That requires some knock-on
changes to how the offset is handled, as well as the the initial
"psize" set when starting a new packet.

Once you start accounting for reads that cut off in 1, 2 or 3 bytes
into the 4 required to parse a size, your program should be able to
run to completion.

Here's a (very ugly) patch I threw together on top of your code:

diff --git a/main.c b/main.c
index 956362b..8873fd5 100644
--- a/main.c
+++ b/main.c
@@ -71,7 +71,7 @@ int main(int argc, char *argv[]) {
  curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
  curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, (long)content_length);
  curl_easy_setopt(curl, CURLOPT_WRITEDATA, &parseread);
- curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, pack_protocol_line);
+ curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &pack_protocol_line);

  res = curl_easy_perform(curl);
  if (curl != CURLE_OK)
diff --git a/post.c b/post.c
index cfffd5c..4f8512c 100644
--- a/post.c
+++ b/post.c
@@ -36,89 +36,83 @@ size_t pack_protocol_line(void *buffer, size_t
size, size_t nmemb, void *userp)
 {
  unsigned char *reply = buffer;
  struct parseread *parseread = userp;
- int offset = 0;
+ int offset = 0, pending = 0, remaining = 0;
  char tmp[5];
- int check;
-
- int pool = size * nmemb;

  printf("\n\n========Start=========\n");
- printf("Current stats: Current state: %d Received: %ld\n",
parseread->state, size*nmemb);
+ printf("Current stats: Current state: %d Received: %ld\n",
parseread->state, nmemb);

- while(offset + 1 < size + nmemb) {
+ while (offset + 3 < nmemb) {
  if (parseread->state == STATE_NEWLINE) {
  printf("== New Object\n");
  bzero(tmp, 5);
- memcpy(tmp, buffer+offset, 4); tmp[4] = '\0';
- check = sscanf(tmp, "%04x", &parseread->osize);

- if (parseread->osize == 0) {
- printf("Only happens if reached terminating 0000\n");
+ if (parseread->bsize > 0) {
+ // If there are buffered size bytes, consume them
+ memcpy(tmp, parseread->buffer, parseread->bsize);
+ memcpy(tmp + parseread->bsize, buffer + offset, 4 - parseread->bsize);
+ offset += 4 - parseread->bsize;
+ parseread->bsize = 0;
+ } else {
+ memcpy(tmp, buffer+offset, 4);
  offset += 4;
- break;
  }
+ tmp[4] = '\0';

- if (check == 0) {
- printf("Error, unable to parse object size\n");
- printf("Size bytes: %02x %02x %02x %02x\n",
- reply[offset+0],
- reply[offset+1],
- reply[offset+2],
- reply[offset+3]);
- printf("Data: %02x %02x %02x %02x\n",
- reply[offset+4],
- reply[offset+5],
- reply[offset+6],
- reply[offset+7]);
- exit(-1);
- }
- else {
- printf("No Error, object is %d bytes\n", parseread->osize);
- printf("Size bytes: %02x %02x %02x %02x\n",
- reply[offset+0],
- reply[offset+1],
- reply[offset+2],
- reply[offset+3]);
- printf("%02x %02x %02x %02x\n",
- reply[offset+4],
- reply[offset+5],
- reply[offset+6],
- reply[offset+7]);
+ printf("Size bytes: %02x %02x %02x %02x\n", tmp[0], tmp[1], tmp[2], tmp[3]);
+ parseread->osize = (int) strtol(tmp, NULL, 16);
+ printf("Parsed size: %d\n", parseread->osize);
+
+ if (parseread->osize == 0) {
+ printf("Only happens if reached terminating 0000\n");
+ break;
  }

- printf("Size: %d\n", parseread->osize);
- parseread->psize = 0;
+ parseread->psize = 4;

  // This classifies the object
- if ( strncmp(reply+offset+4, "NAK\n", 4)==0)
+ if ( strncmp(reply+offset, "NAK\n", 4)==0)
  parseread->state = STATE_NAK;
- else if (reply[offset+4] == 0x02)
+ else if (reply[offset] == 0x02)
  parseread->state = STATE_REMOTE;
  else
  parseread->state = STATE_UNKNOWN;
  }

- if ( (pool - offset) > (parseread->osize - parseread->psize) ) {
- printf("We have enough bytes, moving forward\n");
+ pending = parseread->osize - parseread->psize;
+ remaining = nmemb - offset;
+
+ if ( remaining > pending ) {
+ printf("Read complete; %d more bytes in buffer\n", remaining - pending);
  process_objects(reply+offset, parseread);
  offset += (parseread->osize - parseread->psize);
  parseread->state = STATE_NEWLINE;
  }
- else if ( (pool - offset) ==(parseread->osize - parseread->psize) ) {
- printf("They are the same length\n");
+ else if ( remaining == pending ) {
+ printf("Read complete; buffer exhausted\n");
  process_objects(reply+offset, parseread);
  offset += (parseread->osize - parseread->psize);
  parseread->state = STATE_NEWLINE;
  }
- else if ( (pool - offset) < (parseread->osize - parseread->psize)) {
- printf("We do not have enough bytes\n");
+ else if ( remaining < pending ) {
+ printf("Read complete; still missing %d bytes (%d read of %d)\n",
+ pending - remaining, parseread->psize + remaining, parseread->osize);
  process_objects(reply+offset, parseread);
- parseread->psize += (pool - offset);
- offset = pool;
+ parseread->psize += remaining;
+ offset = nmemb;
  }
  }

  printf("Offset: %d\n", offset);
+ if (offset < nmemb) {
+ // We don't have enough bytes to read the next size, so buffer it
+ printf("Short read; %d bytes left", nmemb - offset);
+ bzero(parseread->buffer, 4);
+ parseread->bsize = nmemb - offset;
+ memcpy(parseread->buffer, buffer+offset, parseread->bsize);
+
+ offset = nmemb;
+ }

  return offset;
 }
diff --git a/post.h b/post.h
index a229342..01a2669 100644
--- a/post.h
+++ b/post.h
@@ -5,6 +5,8 @@ struct parseread {
  int state; // current state
  int osize; // object size
  int psize; // processed size
+ char buffer[4];
+ int bsize;
 };

 #define STATE_NEWLINE 0

Again, it's not pretty, but with those changes a `./post` on your
openbsd URL succeeds.

========Start=========
Current stats: Current state: 999 Received: 503
Read complete; 77 more bytes in buffer
== New Object
Size bytes: 30 30 30 36
Parsed size: 6
Read complete; 71 more bytes in buffer
== New Object
Size bytes: 30 30 34 33
Parsed size: 67
Read complete; 4 more bytes in buffer
Remote: l 1798261 (delta 1438982), reused 1795494 (delta 1436215)
0000
== New Object
Size bytes: 30 30 30 30
Parsed size: 0
Only happens if reached terminating 0000
Offset: 503
curl_easy_perform() failed: No error

Bryan
