Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979BD202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 05:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbdIZFGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 01:06:43 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:57094 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdIZFGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 01:06:42 -0400
Received: by mail-pg0-f44.google.com with SMTP id 7so5312570pgd.13
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ra2Y6V3y6zJt9+GWWmu4s7EW+H2QX1yPwVYPTNShSGY=;
        b=ouVL8z6RxYcps2WEe1OYCHoGnfKuzuPcxnruhIUXZ1lAYA1J0raodDYKvgQBb1KFNW
         mq6bL88/yZDptwaOlTiqEHuchc8lxT47UyymcfkesujnGl/VaorV9105YPmATvwoZSQB
         6aqyGChZuvmeFYU8F43WkhVunuoCNPaH1ngrND4VfNiEXZzIJADax6YfMTBUVcPJSYrk
         Uy83Vy3VB3yq09MDsnwrjgmk1Fkg31dZI69gTs0PuGaF+FC1PiIFRXuGgHbiOuR7hJ5Z
         nwsxd1JTnJvmszJ1tcn1+1YKqBbS6oyga5XonrFesdBhCALm+nH2Ck6uJ+5Eyjz8ms6G
         tTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ra2Y6V3y6zJt9+GWWmu4s7EW+H2QX1yPwVYPTNShSGY=;
        b=p1yRmc0CVQ4I61Ycch2fNHM5p/UKvLpRyEJK2vS6fTlFPp1LBUAFxkkI74vA3XPx43
         C8wb9A0Eh2a/ap7lJaP31zt5pw2dJxjWxresfY0esmttd1S1xOZx1ht8Sn6USBtOEB+g
         6s82YvL3ELvSIgM9vn9R3aT68WQQGv+B6X2ow4Gt3eXRxlrDu3UvA5BS7rjDww0rVhIB
         1v04bgcaXhdc+Ak1X7eOvZL7TKgsMAJvFBbn8yZaHWBF8Ttvf53DnFmXlzE69rc7O7SO
         7YXChTdcMhvw41uCQc0uhJmPwRE6lfxfaJ2Q64iJVwNaiKTlxu3DvvslzgwkVr0iUN3z
         /GPw==
X-Gm-Message-State: AHPjjUiJmhcMnVdgRQdDyjccvoZ3wuCChkh/1HF7E1XKxt+PUG6rWb/+
        CfSbE8B4LRDhARUFAKCUz2KvqL/y
X-Google-Smtp-Source: AOwi7QCjVxp2m5W5DsxkSnewPtJJ8C2zBg0hsiearSu+sbtBnQHF5ttZ0PphjNMrDaChRhxFx34pvw==
X-Received: by 10.84.132.4 with SMTP id 4mr9637722ple.449.1506402400962;
        Mon, 25 Sep 2017 22:06:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id 72sm13794508pfj.102.2017.09.25.22.06.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 22:06:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
References: <20170925155927.32328-1-hanwen@google.com>
        <20170925155927.32328-5-hanwen@google.com>
Date:   Tue, 26 Sep 2017 14:06:39 +0900
In-Reply-To: <20170925155927.32328-5-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Mon, 25 Sep 2017 17:59:27 +0200")
Message-ID: <xmqqing6aw0w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> This mirrors commit bdfdaa4978dd92992737e662f25adc01d32d0774 which did
> the same for strbuf.h:
>
> * API documentation uses /** */ to set it apart from other comments.
>
> * Function names were stripped from the comments.
>
> * Ordering of the header was adjusted to follow the one from the text
>   file.
>
> * Edited some existing comments to follow the new standard.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---

Thanks.  I am not sure if you can safely reorder the contents of the
header files in general, but I trust that you made sure that this
does not introduce problems (e.g. referrals before definition).

Also, I am not sure what "the new standard" refers to.  Have we
established a new standard somewhere?  Did we have discussion on it?
Puzzled.

Thanks.


>  Documentation/technical/api-string-list.txt | 209 ----------------------------
>  string-list.h                               | 187 +++++++++++++++++++++----
>  2 files changed, 159 insertions(+), 237 deletions(-)
>  delete mode 100644 Documentation/technical/api-string-list.txt
>
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> deleted file mode 100644
> index c08402b12..000000000
> --- a/Documentation/technical/api-string-list.txt
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -string-list API
> -===============
> -
> -The string_list API offers a data structure and functions to handle
> -sorted and unsorted string lists.  A "sorted" list is one whose
> -entries are sorted by string value in `strcmp()` order.
> -
> -The 'string_list' struct used to be called 'path_list', but was renamed
> -because it is not specific to paths.
> -
> -The caller:
> -
> -. Allocates and clears a `struct string_list` variable.
> -
> -. Initializes the members. You might want to set the flag `strdup_strings`
> -  if the strings should be strdup()ed. For example, this is necessary
> -  when you add something like git_path("..."), since that function returns
> -  a static buffer that will change with the next call to git_path().
> -+
> -If you need something advanced, you can manually malloc() the `items`
> -member (you need this if you add things later) and you should set the
> -`nr` and `alloc` members in that case, too.
> -
> -. Adds new items to the list, using `string_list_append`,
> -  `string_list_append_nodup`, `string_list_insert`,
> -  `string_list_split`, and/or `string_list_split_in_place`.
> -
> -. Can check if a string is in the list using `string_list_has_string` or
> -  `unsorted_string_list_has_string` and get it from the list using
> -  `string_list_lookup` for sorted lists.
> -
> -. Can sort an unsorted list using `string_list_sort`.
> -
> -. Can remove duplicate items from a sorted list using
> -  `string_list_remove_duplicates`.
> -
> -. Can remove individual items of an unsorted list using
> -  `unsorted_string_list_delete_item`.
> -
> -. Can remove items not matching a criterion from a sorted or unsorted
> -  list using `filter_string_list`, or remove empty strings using
> -  `string_list_remove_empty_items`.
> -
> -. Finally it should free the list using `string_list_clear`.
> -
> -Example:
> -
> -----
> -struct string_list list = STRING_LIST_INIT_NODUP;
> -int i;
> -
> -string_list_append(&list, "foo");
> -string_list_append(&list, "bar");
> -for (i = 0; i < list.nr; i++)
> -	printf("%s\n", list.items[i].string)
> -----
> -
> -NOTE: It is more efficient to build an unsorted list and sort it
> -afterwards, instead of building a sorted list (`O(n log n)` instead of
> -`O(n^2)`).
> -+
> -However, if you use the list to check if a certain string was added
> -already, you should not do that (using unsorted_string_list_has_string()),
> -because the complexity would be quadratic again (but with a worse factor).
> -
> -Functions
> ----------
> -
> -* General ones (works with sorted and unsorted lists as well)
> -
> -`string_list_init`::
> -
> -	Initialize the members of the string_list, set `strdup_strings`
> -	member according to the value of the second parameter.
> -
> -`filter_string_list`::
> -
> -	Apply a function to each item in a list, retaining only the
> -	items for which the function returns true.  If free_util is
> -	true, call free() on the util members of any items that have
> -	to be deleted.  Preserve the order of the items that are
> -	retained.
> -
> -`string_list_remove_empty_items`::
> -
> -	Remove any empty strings from the list.  If free_util is true,
> -	call free() on the util members of any items that have to be
> -	deleted.  Preserve the order of the items that are retained.
> -
> -`print_string_list`::
> -
> -	Dump a string_list to stdout, useful mainly for debugging purposes. It
> -	can take an optional header argument and it writes out the
> -	string-pointer pairs of the string_list, each one in its own line.
> -
> -`string_list_clear`::
> -
> -	Free a string_list. The `string` pointer of the items will be freed in
> -	case the `strdup_strings` member of the string_list is set. The second
> -	parameter controls if the `util` pointer of the items should be freed
> -	or not.
> -
> -* Functions for sorted lists only
> -
> -`string_list_has_string`::
> -
> -	Determine if the string_list has a given string or not.
> -
> -`string_list_insert`::
> -
> -	Insert a new element to the string_list. The returned pointer can be
> -	handy if you want to write something to the `util` pointer of the
> -	string_list_item containing the just added string. If the given
> -	string already exists the insertion will be skipped and the
> -	pointer to the existing item returned.
> -+
> -Since this function uses xrealloc() (which die()s if it fails) if the
> -list needs to grow, it is safe not to check the pointer. I.e. you may
> -write `string_list_insert(...)->util = ...;`.
> -
> -`string_list_lookup`::
> -
> -	Look up a given string in the string_list, returning the containing
> -	string_list_item. If the string is not found, NULL is returned.
> -
> -`string_list_remove_duplicates`::
> -
> -	Remove all but the first of consecutive entries that have the
> -	same string value.  If free_util is true, call free() on the
> -	util members of any items that have to be deleted.
> -
> -* Functions for unsorted lists only
> -
> -`string_list_append`::
> -
> -	Append a new string to the end of the string_list.  If
> -	`strdup_string` is set, then the string argument is copied;
> -	otherwise the new `string_list_entry` refers to the input
> -	string.
> -
> -`string_list_append_nodup`::
> -
> -	Append a new string to the end of the string_list.  The new
> -	`string_list_entry` always refers to the input string, even if
> -	`strdup_string` is set.  This function can be used to hand
> -	ownership of a malloc()ed string to a `string_list` that has
> -	`strdup_string` set.
> -
> -`string_list_sort`::
> -
> -	Sort the list's entries by string value in `strcmp()` order.
> -
> -`unsorted_string_list_has_string`::
> -
> -	It's like `string_list_has_string()` but for unsorted lists.
> -
> -`unsorted_string_list_lookup`::
> -
> -	It's like `string_list_lookup()` but for unsorted lists.
> -+
> -The above two functions need to look through all items, as opposed to their
> -counterpart for sorted lists, which performs a binary search.
> -
> -`unsorted_string_list_delete_item`::
> -
> -	Remove an item from a string_list. The `string` pointer of the items
> -	will be freed in case the `strdup_strings` member of the string_list
> -	is set. The third parameter controls if the `util` pointer of the
> -	items should be freed or not.
> -
> -`string_list_split`::
> -`string_list_split_in_place`::
> -
> -	Split a string into substrings on a delimiter character and
> -	append the substrings to a `string_list`.  If `maxsplit` is
> -	non-negative, then split at most `maxsplit` times.  Return the
> -	number of substrings appended to the list.
> -+
> -`string_list_split` requires a `string_list` that has `strdup_strings`
> -set to true; it leaves the input string untouched and makes copies of
> -the substrings in newly-allocated memory.
> -`string_list_split_in_place` requires a `string_list` that has
> -`strdup_strings` set to false; it splits the input string in place,
> -overwriting the delimiter characters with NULs and creating new
> -string_list_items that point into the original string (the original
> -string must therefore not be modified or freed while the `string_list`
> -is in use).
> -
> -
> -Data structures
> ----------------
> -
> -* `struct string_list_item`
> -
> -Represents an item of the list. The `string` member is a pointer to the
> -string, and you may use the `util` member for any purpose, if you want.
> -
> -* `struct string_list`
> -
> -Represents the list itself.
> -
> -. The array of items are available via the `items` member.
> -. The `nr` member contains the number of items stored in the list.
> -. The `alloc` member is used to avoid reallocating at every insertion.
> -  You should not tamper with it.
> -. Setting the `strdup_strings` member to 1 will strdup() the strings
> -  before adding them, see above.
> -. The `compare_strings_fn` member is used to specify a custom compare
> -  function, otherwise `strcmp()` is used as the default function.
> diff --git a/string-list.h b/string-list.h
> index 79ae567cb..e63ee4854 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -1,6 +1,72 @@
>  #ifndef STRING_LIST_H
>  #define STRING_LIST_H
>  
> +/**
> + * The string_list API offers a data structure and functions to handle
> + * sorted and unsorted arrays of strings.  A "sorted" list is one whose
> + * entries are sorted by string value in `strcmp()` order.
> + *
> + * The 'string_list' struct used to be called 'path_list', but was renamed
> + * because it is not specific to paths.
> + *
> + * The caller:
> + *
> + * . Allocates and clears a `struct string_list` variable.
> + *
> + * . Initializes the members. You might want to set the flag `strdup_strings`
> + *   if the strings should be strdup()ed. For example, this is necessary
> + *   when you add something like git_path("..."), since that function returns
> + *   a static buffer that will change with the next call to git_path().
> + *
> + * If you need something advanced, you can manually malloc() the `items`
> + * member (you need this if you add things later) and you should set the
> + * `nr` and `alloc` members in that case, too.
> + *
> + * . Adds new items to the list, using `string_list_append`,
> + *   `string_list_append_nodup`, `string_list_insert`,
> + *   `string_list_split`, and/or `string_list_split_in_place`.
> + *
> + * . Can check if a string is in the list using `string_list_has_string` or
> + *   `unsorted_string_list_has_string` and get it from the list using
> + *   `string_list_lookup` for sorted lists.
> + *
> + * . Can sort an unsorted list using `string_list_sort`.
> + *
> + * . Can remove duplicate items from a sorted list using
> + *   `string_list_remove_duplicates`.
> + *
> + * . Can remove individual items of an unsorted list using
> + *   `unsorted_string_list_delete_item`.
> + *
> + * . Can remove items not matching a criterion from a sorted or unsorted
> + *   list using `filter_string_list`, or remove empty strings using
> + *   `string_list_remove_empty_items`.
> + *
> + * . Finally it should free the list using `string_list_clear`.
> + *
> + * Example:
> + *
> + *     struct string_list list = STRING_LIST_INIT_NODUP;
> + *     int i;
> + *
> + *     string_list_append(&list, "foo");
> + *     string_list_append(&list, "bar");
> + *     for (i = 0; i < list.nr; i++)
> + *             printf("%s\n", list.items[i].string)
> + *
> + * NOTE: It is more efficient to build an unsorted list and sort it
> + * afterwards, instead of building a sorted list (`O(n log n)` instead of
> + * `O(n^2)`).
> + *
> + * However, if you use the list to check if a certain string was added
> + * already, you should not do that (using unsorted_string_list_has_string()),
> + * because the complexity would be quadratic again (but with a worse factor).
> + */
> +
> +/**
> + * Represents an item of the list. The `string` member is a pointer to the
> + * string, and you may use the `util` member for any purpose, if you want.
> + */
>  struct string_list_item {
>  	char *string;
>  	void *util;
> @@ -8,6 +74,18 @@ struct string_list_item {
>  
>  typedef int (*compare_strings_fn)(const char *, const char *);
>  
> +/**
> + * Represents the list itself.
> + *
> + * . The array of items are available via the `items` member.
> + * . The `nr` member contains the number of items stored in the list.
> + * . The `alloc` member is used to avoid reallocating at every insertion.
> + *   You should not tamper with it.
> + * . Setting the `strdup_strings` member to 1 will strdup() the strings
> + *   before adding them, see above.
> + * . The `compare_strings_fn` member is used to specify a custom compare
> + *   function, otherwise `strcmp()` is used as the default function.
> + */
>  struct string_list {
>  	struct string_list_item *items;
>  	unsigned int nr, alloc;
> @@ -18,35 +96,61 @@ struct string_list {
>  #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>  
> +/* General functions which work with both sorted and unsorted lists. */
> +
> +/**
> + * Initialize the members of the string_list, set `strdup_strings`
> + * member according to the value of the second parameter.
> + */
>  void string_list_init(struct string_list *list, int strdup_strings);
>  
> +/**
> + * Apply want to each item in list, retaining only the ones for which
> + * the function returns true.  If free_util is true, call free() on
> + * the util members of any items that have to be deleted.  Preserve
> + * the order of the items that are retained.
> + */
> +void filter_string_list(struct string_list *list, int free_util,
> +			string_list_each_func_t want, void *cb_data);
> +
> +/**
> + * Dump a string_list to stdout, useful mainly for debugging
> + * purposes. It can take an optional header argument and it writes out
> + * the string-pointer pairs of the string_list, each one in its own
> + * line.
> + */
>  void print_string_list(const struct string_list *p, const char *text);
> +
> +/**
> + * Free a string_list. The `string` pointer of the items will be freed
> + * in case the `strdup_strings` member of the string_list is set. The
> + * second parameter controls if the `util` pointer of the items should
> + * be freed or not.
> + */
>  void string_list_clear(struct string_list *list, int free_util);
>  
> -/* Use this function to call a custom clear function on each util pointer */
> -/* The string associated with the util pointer is passed as the second argument */
> +/**
> + * Callback type for `string_list_clear_func`.  The string associated
> + * with the util pointer is passed as the second argument
> + */
>  typedef void (*string_list_clear_func_t)(void *p, const char *str);
> +
> +/** Call a custom clear function on each util pointer */
>  void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
>  
> -/* Use this function or the macro below to iterate over each item */
>  typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
> +
> +/** Iterate over each item. */
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t, void *cb_data);
> +
> +/** Iterate over each item, as a macro. */
>  #define for_each_string_list_item(item,list)            \
>  	for (item = (list)->items;                      \
>  	     item && item < (list)->items + (list)->nr; \
>  	     ++item)
>  
> -/*
> - * Apply want to each item in list, retaining only the ones for which
> - * the function returns true.  If free_util is true, call free() on
> - * the util members of any items that have to be deleted.  Preserve
> - * the order of the items that are retained.
> - */
> -void filter_string_list(struct string_list *list, int free_util,
> -			string_list_each_func_t want, void *cb_data);
> -
> -/*
> +/**
>   * Remove any empty strings from the list.  If free_util is true, call
>   * free() on the util members of any items that have to be deleted.
>   * Preserve the order of the items that are retained.
> @@ -54,25 +158,34 @@ void filter_string_list(struct string_list *list, int free_util,
>  void string_list_remove_empty_items(struct string_list *list, int free_util);
>  
>  /* Use these functions only on sorted lists: */
> +
> +/** Determine if the string_list has a given string or not. */
>  int string_list_has_string(const struct string_list *list, const char *string);
>  int string_list_find_insert_index(const struct string_list *list, const char *string,
>  				  int negative_existing_index);
> -/*
> - * Inserts the given string into the sorted list.
> - * If the string already exists, the list is not altered.
> - * Returns the string_list_item, the string is part of.
> +
> +/**
> + * Insert a new element to the string_list. The returned pointer can
> + * be handy if you want to write something to the `util` pointer of
> + * the string_list_item containing the just added string. If the given
> + * string already exists the insertion will be skipped and the pointer
> + * to the existing item returned.
> + *
> + * Since this function uses xrealloc() (which die()s if it fails) if the
> + * list needs to grow, it is safe not to check the pointer. I.e. you may
> + * write `string_list_insert(...)->util = ...;`.
>   */
>  struct string_list_item *string_list_insert(struct string_list *list, const char *string);
>  
> -/*
> - * Removes the given string from the sorted list.
> - * If the string doesn't exist, the list is not altered.
> +/**
> + * Remove the given string from the sorted list.  If the string
> + * doesn't exist, the list is not altered.
>   */
>  extern void string_list_remove(struct string_list *list, const char *string,
>  			       int free_util);
>  
> -/*
> - * Checks if the given string is part of a sorted list. If it is part of the list,
> +/**
> + * Check if the given string is part of a sorted list. If it is part of the list,
>   * return the coresponding string_list_item, NULL otherwise.
>   */
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
> @@ -87,14 +200,14 @@ void string_list_remove_duplicates(struct string_list *sorted_list, int free_uti
>  
>  /* Use these functions only on unsorted lists: */
>  
> -/*
> +/**
>   * Add string to the end of list.  If list->strdup_string is set, then
>   * string is copied; otherwise the new string_list_entry refers to the
>   * input string.
>   */
>  struct string_list_item *string_list_append(struct string_list *list, const char *string);
>  
> -/*
> +/**
>   * Like string_list_append(), except string is never copied.  When
>   * list->strdup_strings is set, this function can be used to hand
>   * ownership of a malloc()ed string to list without making an extra
> @@ -102,16 +215,34 @@ struct string_list_item *string_list_append(struct string_list *list, const char
>   */
>  struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
>  
> +/**
> + * Sort the list's entries by string value in `strcmp()` order.
> + */
>  void string_list_sort(struct string_list *list);
> +
> +/**
> + * Like `string_list_has_string()` but for unsorted lists. Linear in
> + * size of the list.
> + */
>  int unsorted_string_list_has_string(struct string_list *list, const char *string);
> +
> +/**
> + * Like `string_list_lookup()` but for unsorted lists. Linear in size
> + * of the list.
> + */
>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>  						     const char *string);
> -
> +/**
> + * Remove an item from a string_list. The `string` pointer of the
> + * items will be freed in case the `strdup_strings` member of the
> + * string_list is set. The third parameter controls if the `util`
> + * pointer of the items should be freed or not.
> + */
>  void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
>  
> -/*
> - * Split string into substrings on character delim and append the
> - * substrings to list.  The input string is not modified.
> +/**
> + * Split string into substrings on character `delim` and append the
> + * substrings to `list`.  The input string is not modified.
>   * list->strdup_strings must be set, as new memory needs to be
>   * allocated to hold the substrings.  If maxsplit is non-negative,
>   * then split at most maxsplit times.  Return the number of substrings
